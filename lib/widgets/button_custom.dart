import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.onTap, required this.child});

  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.green, Colors.greenAccent]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
