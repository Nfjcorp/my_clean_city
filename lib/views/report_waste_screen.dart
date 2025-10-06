import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class ReportWasteForm extends StatefulWidget {
  const ReportWasteForm({super.key});

  @override
  State<ReportWasteForm> createState() => _ReportWasteFormState();
}

class _ReportWasteFormState extends State<ReportWasteForm> {
  final _formKey = GlobalKey<FormState>();
  final _descCtrl = TextEditingController();
  final _addrCtrl = TextEditingController();

  File? _image;
  bool _loading = false;
  Position? _position;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) setState(() => _image = File(file.path));
  }

  Future<void> _getLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission localisation refusée")),
      );
      return;
    }
    final pos = await Geolocator.getCurrentPosition();
    setState(() => _position = pos);
    _addrCtrl.text = "Lat:${pos.latitude}, Lng:${pos.longitude}";
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("Utilisateur non connecté");

      String? imageUrl;
      if (_image != null) {
        final ref = FirebaseStorage.instance.ref(
          "collectes/${DateTime.now().millisecondsSinceEpoch}.jpg",
        );
        await ref.putFile(_image!);
        imageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection("reports").add({
        "description": _descCtrl.text,
        "adresse": _addrCtrl.text,
        "latitude": _position?.latitude,
        "longitude": _position?.longitude,
        "photoUrl": imageUrl,
        "status": "pending",
        "citizenId": uid,
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Dépôt signalé avec succès")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Widget build(BuildContext context) {
    final green = const Color(0xFF34A853);
    final lightBackground = const Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text("Signaler un dépôt d’ordure"),
        backgroundColor: green,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Contribuez à un environnement propre 🌱",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Description
              TextFormField(
                controller: _descCtrl,
                decoration: InputDecoration(
                  labelText: "Description",
                  prefixIcon: const Icon(Icons.notes, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator:
                    (v) =>
                        v == null || v.isEmpty
                            ? "Entrez une description"
                            : null,
              ),
              const SizedBox(height: 16),

              // Adresse
              TextFormField(
                controller: _addrCtrl,
                decoration: InputDecoration(
                  labelText: "Adresse / Coordonnées",
                  prefixIcon: const Icon(Icons.place, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.my_location, color: Colors.green),
                    onPressed: _getLocation,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator:
                    (v) => v == null || v.isEmpty ? "Entrez une adresse" : null,
              ),
              const SizedBox(height: 16),

              // Photo
              _image != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _image!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  : OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera_alt, color: Colors.green),
                    label: const Text("Prendre une photo"),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: green, width: 1.5),
                      foregroundColor: green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
              const SizedBox(height: 24),

              // Submit Button
              _loading
                  ? const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  )
                  : ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.send),
                    label: const Text("Envoyer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
