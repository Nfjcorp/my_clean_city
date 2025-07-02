import 'package:flutter/material.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/views/auth/login_screen.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          data: 'Profile',
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.person)),
            TextCustom(data: user != null ? '${user.email}' : '', fontSize: 18),
            TextCustom(
              data: 'Compte',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            InkWell(
              onTap: () async {
                final navigator = Navigator.of(context);
                await auth.signOut();
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(onTap: () {}),
                  ),
                  (route) => false,
                );
              },
              child: TextCustom(data: 'Déconnexion', fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
