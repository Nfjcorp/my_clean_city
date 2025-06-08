import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/views/auth/forgot_password_screen.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/multi_container_row.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isTrue = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void login() async {
    final auth = Provider.of<AuthProviders>(context, listen: false);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (formKey.currentState!.validate()) return;
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextCustom(
            data: 'Veuillez entrer un mot de passe valide',
            fontSize: 14,
          ),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    }
    try {
      await auth.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await firestore.collection("users").doc(auth.user!.uid).set({
        'uid': auth.user!.uid,
        'email': emailController.text.trim(),
      }, SetOptions(merge: true));
      formKey.currentState?.reset();  // Réinisialise les états de validation
      emailController.clear();        // vide les Controlleurs manuellement
      passwordController.clear();
      confirmController.clear();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
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
                FormCustom(
                  formKey: formKey,
                  child: Column(
                    children: [
                      TextFieldCustom(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email';
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2}$',
                          ).hasMatch(value)) {
                            return 'please enter a valid email';
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
                            return 'please enter valid password';
                          } else if (value.length < 8) {
                            return 'password must be at least 8 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFieldCustom(
                        controller: confirmController,
                        labelText: 'Confirm your password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isTrue = !isTrue;
                            });
                          },
                          icon:
                              isTrue
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.remove_red_eye),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please confirm your password';
                          } else if (value.length < 8) {
                            return 'password must be at least 8 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
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
                  onTap: login,
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
