//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviders extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  User? get user => _user;

  // Sign in method with email and password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      /* final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); */
      //final user = cred.user;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign up method with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  // reset Password
  Future<void> resetPaswword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // get currentUser
  User? getCurrentUser() {
    _user = _auth.currentUser;
    notifyListeners();
    return _user;
  }

  /* // Update photoURL
  Future<void> updatePhotoURL(String photoURL) async {
    try {
      if (user != null) {
        await user!.updatePhotoURL(photoURL);
      }
    } catch (e) {}
  }
 */
  // Update displyname
  Future<void> updateDisplayName(String displayName) async {
    try {
      if (user != null) {
        await user!.updateDisplayName(displayName);
      }
    } catch (e) {}
  }
}
