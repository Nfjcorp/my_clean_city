import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  Future<void> addRequest({
    required String adresse,
    required String phone,
    required String quantite,
  }) async {
    try {
      await requests.add({
        'adresse': adresse,
        'phone': phone,
        'quantite': quantite,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding request: $e');
      throw e; // Re-throw the error for further handling if needed
    }
  }
}