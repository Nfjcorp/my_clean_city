import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/views/auth/login_screen.dart';
import 'package:my_clean_city/views/home/body_home.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          return FutureBuilder(
            future: _getUserRole(snapshot.data!.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (roleSnapshot.hasError || roleSnapshot.data == null) {
                return Scaffold(body: Center(child: Text("Role non trouvé")));
              }

              final role = roleSnapshot.data!;
              if (role == 'citoyen') {
                return BodyHome();
              }
              if (role == 'agent') {
                return BodyHome();
              }
              if (role == 'admin') {
                return BodyHome();
              }

              return Scaffold(body: Center(child: Text('Role inconnu')));
            },
          );
        } else {
          return LoginScreen(onTap: () {});
        }
      },
    );
  }

  Future<String?> _getUserRole(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.data()?["role"];
  }
}
