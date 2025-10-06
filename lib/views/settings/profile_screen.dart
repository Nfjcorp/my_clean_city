import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      setState(() {
        userData = doc.data();
      });
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Déconnexion Réussie')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de déconnexion: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviders>(context, listen: false);
    final user = auth.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: TextCustom(
          data: 'Profil',
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child:
            userData == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                  height: 400,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            userData!['avatarUrl'] != null
                                ? NetworkImage(userData!['avatarUrl'])
                                : null,
                        child:
                            userData!['avatarUrl'] == null
                                ? Icon(Icons.person, size: 40)
                                : null,
                      ),
                      SizedBox(height: 20),
                      TextCustom(
                        data: userData!['name'] ?? 'Nom inconnu',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      TextCustom(data: user?.email ?? '', fontSize: 18),
                      SizedBox(height: 8),
                      TextCustom(
                        data: 'Rôle : ${userData!['role'] ?? 'Non défini'}',
                        fontSize: 16,
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () => signOut(context),
                        child: TextCustom(
                          data: 'Déconnexion',
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
