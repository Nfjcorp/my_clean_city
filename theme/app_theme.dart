import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}

Widget text(BuildContext context) {
  return TextField(
    decoration: InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    ),
  );
}

class User {
  final String name;

  User({required this.name});

  
}
