import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: const Text('Settings'),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: const Text('Theme'),
                onTap: () {
                  Navigator.pushNamed(context, '/theme');
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
