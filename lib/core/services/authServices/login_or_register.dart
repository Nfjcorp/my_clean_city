import 'package:flutter/material.dart';
import 'package:my_clean_city/views/auth/login_screen.dart';
import 'package:my_clean_city/views/auth/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogin = true;

  void toggleScrenn(){
    setState(() {
      showLogin = !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginScreen(
        onTap: toggleScrenn,
      );
    } else {
      return RegisterScreen(
        onTap: toggleScrenn,
      );
    }
  }
}
