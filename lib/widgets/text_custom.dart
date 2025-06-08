import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({super.key, required this.data, this.textAlign, required this.fontSize, this.fontWeight, this.fontFamily = 'Roboto', this.color});

  final String data;
  final double fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
