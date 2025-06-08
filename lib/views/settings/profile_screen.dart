import 'package:flutter/material.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviders>(context);
    final user = auth.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
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
            TextCustom(
              data: 'Compte',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
