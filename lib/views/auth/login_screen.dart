import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/views/auth/forgot_password_screen.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/multi_container_row.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isTrue = false;
  bool loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      formKey.currentState!.reset(); // Réinisialise les états de validation
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Erreur')));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(height: 250, 'assets/images/login.png'),
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Let\'s Login For Explore Clean City',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldCustom(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFieldCustom(
                        controller: passwordController,
                        obscureText: isTrue,
                        labelText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isTrue = !isTrue;
                            });
                          },
                          icon:
                              isTrue
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez un mot de passe valide';
                          } else if (value.length < 8) {
                            return 'Le mot de passe doit contenir au moins 8 caractères';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap:
                        () =>
                            navigateToNextPage(context, ForgotPasswordScreen()),
                    child: TextCustom(
                      data: 'Forgot Password?',
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                ButtonCustom(
                  onTap: _login,
                  child: Center(
                    child: TextCustom(
                      textAlign: TextAlign.center,
                      data: 'Sign in',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      child: Divider(height: 1, endIndent: 6, indent: 5),
                    ),
                    TextCustom(
                      data: 'You Can Connect With',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Divider(height: 1.0, endIndent: 8, indent: 5),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MultiContainerRow(),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(
                      data: "Don't Have Account?",
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      child: TextCustom(
                        data: 'Sign up here',
                        fontSize: 13,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
