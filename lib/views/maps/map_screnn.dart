import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScrenn extends StatefulWidget {
  const MapScrenn({super.key});

  @override
  State<MapScrenn> createState() => _MapPageState();
}

class _MapPageState extends State<MapScrenn> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-33.86, 151.20);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  double userLat = 0.0;
  double userLng = 0.0;

  @override
  void initState() {
    _fechLocationUser();
    super.initState();
  }

  Future _fechLocationUser() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw 'Le service de localisation est descativé';
      }

      // verifie les permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        throw 'Les permissions de localisation sont refusées';
      }

      Position position = await Geolocator.getCurrentPosition();
      userLat = position.latitude;
      userLng = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
      ),
    );
  }
}
