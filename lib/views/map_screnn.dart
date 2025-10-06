import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:my_clean_city/models/quartier_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  final String apiKey =
      "AIzaSyDQTuUY9zgLfGnCQ3N4r7a8tNfAzjTmEic"; // 🔑 Mets ta vraie clé API ici (celle activée avec Maps SDK)
  late GooglePlace googlePlace;

  final TextEditingController _searchController = TextEditingController();
  List<AutocompletePrediction> predictions = [];

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  bool _isLocating = false; // Pour afficher le loader pendant la localisation

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(apiKey);
    _checkLocationPermissionAndGetPosition();
    _setQuartierMarkers();
  }

  /// 🔹 Vérifie les permissions et récupère la position actuelle
  Future<void> _checkLocationPermissionAndGetPosition() async {
    setState(() => _isLocating = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationDialog(
        "Service désactivé",
        "Veuillez activer la localisation sur votre appareil.",
      );
      setState(() => _isLocating = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showLocationDialog(
          "Permission refusée",
          "L'application a besoin de votre autorisation pour accéder à la localisation.",
        );
        setState(() => _isLocating = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showLocationDialog(
        "Permission refusée définitivement",
        "Veuillez activer la permission dans les paramètres de l'application.",
      );
      setState(() => _isLocating = false);
      return;
    }

    // ✅ Si tout est OK
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId("current"),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: "Ma position"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );
      _isLocating = false;
    });
  }

  /// 🔹 Ajoute les marqueurs des quartiers
  void _setQuartierMarkers() {
    for (var q in quartiers) {
      _markers.add(
        Marker(
          markerId: MarkerId(q.nom),
          position: LatLng(q.latitude, q.longitude),
          infoWindow: InfoWindow(title: q.nom),
        ),
      );
    }
  }

  /// 🔹 Recherche automatique
  void _autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  /// 🔹 Va à l’endroit sélectionné
  Future<void> _goToPlace(String placeId) async {
    var details = await googlePlace.details.get(placeId);
    if (details != null && details.result != null) {
      final lat = details.result!.geometry!.location!.lat;
      final lng = details.result!.geometry!.location!.lng;
      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat!, lng!)));

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(details.result!.name!),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: details.result!.name),
          ),
        );
      });
    }
  }

  /// 🔹 Montre une boîte de dialogue personnalisée
  Future<void> _showLocationDialog(String title, String message) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body:
          _currentPosition == null || _isLocating
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Recherche de votre position...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
              : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 13,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onMapCreated: (controller) => mapController = controller,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                  // Barre de recherche
                  Positioned(
                    top: 40,
                    left: 15,
                    right: 15,
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: "Rechercher un quartier...",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: theme.primaryColor,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                style: const TextStyle(fontSize: 16),
                                onChanged: _autoCompleteSearch,
                              ),
                            ),
                            if (predictions.isNotEmpty)
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: predictions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(
                                        Icons.location_on,
                                        color: theme.primaryColor,
                                      ),
                                      title: Text(
                                        predictions[index].description!,
                                      ),
                                      onTap: () {
                                        _goToPlace(predictions[index].placeId!);
                                        _searchController.clear();
                                        setState(() {
                                          predictions = [];
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bouton recentrage
                  Positioned(
                    bottom: 40,
                    right: 20,
                    child: Material(
                      color: theme.colorScheme.secondary,
                      shape: const CircleBorder(),
                      elevation: 8,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        splashColor: theme.colorScheme.primary.withOpacity(0.3),
                        onTap: _checkLocationPermissionAndGetPosition,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.my_location,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
