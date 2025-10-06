import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';

class CitizenCollectForm extends StatefulWidget {
  @override
  _CitizenCollectFormState createState() => _CitizenCollectFormState();
}

class _CitizenCollectFormState extends State<CitizenCollectForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedWasteType;
  Position? _currentPosition;
  bool _loadingLocation = false;

  final List<String> _wasteTypes = [
    "Plastique",
    "Verre",
    "Métal",
    "Papier",
    "Organique",
    "Autres",
  ];

  Future<void> _getLocation() async {
    setState(() => _loadingLocation = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _loadingLocation = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Activez le GPS pour continuer.")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _loadingLocation = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permission de localisation refusée.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _loadingLocation = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission de localisation bloquée.")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _loadingLocation = false;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _currentPosition != null) {
      final user = FirebaseAuth.instance.currentUser;
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection("collects").add({
        "citizenId": user!.uid,
        "phone": _phoneController.text.trim(),
        "wasteType": _selectedWasteType,
        "quantity": _quantityController.text.trim(),
        "description": _descriptionController.text.trim(),
        "latitude": _currentPosition!.latitude,
        "longitude": _currentPosition!.longitude,
        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      final userRef = FirebaseFirestore.instance.collection("users").doc(uid);
      await userRef.update({"points": FieldValue.increment(5)});

      
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Demande envoyée avec succès ✅")));

      _formKey.currentState!.reset();
      setState(() {
        _currentPosition = null;
        _selectedWasteType = null;
      });
      _phoneController.clear();
      _quantityController.clear();
      _descriptionController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Veuillez remplir le formulaire et activer la localisation.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: TextCustom(
          data: "Nouvelle demande de collecte",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      data: 'Numéro de téléphone',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    TextFieldCustom(
                      controller: _phoneController,
                      prefixIcon: Icon(Icons.phone, color: Colors.green),
                      labelText: 'Ex: 6 80 80 80 80',
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Entrez votre numéro"
                                  : null,
                    ),
                    SizedBox(height: 18),
                    TextCustom(
                      data: 'Type de déchet',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedWasteType,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        labelText: 'Type de déchet',
                        prefixIcon: Icon(Icons.recycling, color: Colors.green),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items:
                          _wasteTypes
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() => _selectedWasteType = value);
                      },
                      validator:
                          (value) =>
                              value == null ? "Veuillez choisir un type" : null,
                    ),
                    SizedBox(height: 18),
                    TextCustom(
                      data: 'Quantité',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    TextFieldCustom(
                      controller: _quantityController,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Entrez la quantité"
                                  : null,
                      labelText: 'Quantité approximative (kg, sacs...)',
                      prefixIcon: Icon(Icons.scale, color: Colors.green),
                    ),
                    SizedBox(height: 18),
                    TextCustom(
                      data: 'Description',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    TextFieldCustom(
                      labelText: 'Description (facultatif)',
                      prefixIcon: Icon(Icons.description, color: Colors.green),
                      maxLines: 3,
                      controller: _descriptionController,
                    ),
                    SizedBox(height: 18),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: _getLocation,
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 15,
                      ),
                      label:
                          _loadingLocation
                              ? Text(
                                "Localisation en cours...",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                              : Text(
                                _currentPosition == null
                                    ? "Ajouter ma localisation"
                                    : "Localisation ajoutée ✅",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                    SizedBox(height: 24),
                    ButtonCustom(
                      onTap: () => _submitForm(),
                      child: Center(
                        child: TextCustom(
                          data: "Envoyer ma demande",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
