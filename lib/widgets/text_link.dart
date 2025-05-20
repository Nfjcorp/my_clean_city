import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink({super.key, required this.child, required this.onTap});

  final Widget child;
  final  void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: child);
  }
}
