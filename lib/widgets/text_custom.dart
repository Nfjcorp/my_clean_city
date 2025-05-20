import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({
    super.key,
    required this.data,
    required this.style, 
    this.textAlign,
    });

  final String data;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data, style: style);
  }
}
