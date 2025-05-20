import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/colors.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/core/utils/styles.dart';
import 'package:my_clean_city/views/auth/login_screen.dart';
import 'package:my_clean_city/views/home/home_screen.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/multi_container_row.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';
import 'package:my_clean_city/widgets/text_link.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Create Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Register to join Clean City',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              FormCustom(
                formKey: formKey,
                child: Column(
                  children: [
                    TextFieldCustom(
                      controller: nameController,
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFieldCustom(
                      controller: emailController,
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFieldCustom(
                      controller: passwordController,
                      obscureText: isObscure,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon:
                            isObscure
                                ? Icon(Icons.remove_red_eye_outlined)
                                : Icon(Icons.remove_red_eye),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFieldCustom(
                      controller: confirmController,
                      obscureText: isObscure,
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon:
                            isObscure
                                ? Icon(Icons.remove_red_eye_outlined)
                                : Icon(Icons.remove_red_eye),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ButtonCustom(
                onTap: () {
                  navigateToNextPage(context, HomeScreen());
                },
                child: TextCustom(
                  textAlign: TextAlign.center,
                  data: 'Sign Up',
                  style: buttonStyle(color: whiteColor),
                ),
              ),
              SizedBox(height: 40),
              TextCustom(
                data: 'Or Register With',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              MultiContainerRow(),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustom(
                    data: 'Already have an account? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextLink(
                    child: TextCustom(
                      data: 'Login',
                      style: legendStyle(color: lightLink),
                    ),
                    onTap: () => navigateToNextPage(context, LoginScreen()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
