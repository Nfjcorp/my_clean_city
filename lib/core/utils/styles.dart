import 'package:flutter/material.dart';

// Large fonts style
TextStyle displayLarge(double fontSize, String fontFamily, Color color, FontWeight fontWeight) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight
  );
}

// Meduim fonts style
TextStyle displaySmall({double fontSize = 24, String fontFamily = 'Roboto', required Color color, FontWeight fontWeight = FontWeight.w400}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight
  );
}

// Normal fonts style
TextStyle normalStyle({double fontSize = 16, String fontFamily = 'Roboto', required Color color, FontWeight fontWeight = FontWeight.w400}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight
  );
}

// Button fonts style
TextStyle buttonStyle({double fontSize = 16, String fontFamily = 'Roboto', required Color color, FontWeight fontWeight = FontWeight.w400}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight
  );
}

// Legend fonts style
TextStyle legendStyle({double fontSize = 12, String fontFamily = 'Roboto', required Color color, FontWeight fontWeight = FontWeight.w400}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight
  );
}

