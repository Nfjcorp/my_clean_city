import 'package:flutter/material.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'helloe world'
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
