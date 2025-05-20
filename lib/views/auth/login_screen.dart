import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/colors.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/core/utils/styles.dart';
import 'package:my_clean_city/views/auth/forgot_password_screen.dart';
import 'package:my_clean_city/views/auth/register_screen.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/multi_container_row.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';
import 'package:my_clean_city/widgets/text_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isTrue = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
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
                                  ? Icon(Icons.remove_red_eye_outlined)
                                  : Icon(Icons.remove_red_eye),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email';
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                          ).hasMatch(value)) {
                            return 'please enter a valid email';
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
                            return 'please enter your email';
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                          ).hasMatch(value)) {
                            return 'please enter a valid email';
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap:
                        () =>
                            navigateToNextPage(context, ForgotPasswordScreen()),
                    child: Text('Forgot Password'),
                  ),
                ),
                SizedBox(height: 20),
                ButtonCustom(
                  onTap: () {},
                  child: TextCustom(
                    textAlign: TextAlign.center,
                    data: 'Sign in',
                    style: buttonStyle(color: lightPrimaryButton),
                  ),
                ),
                SizedBox(height: 40),
                TextCustom(
                  data: 'You Can Connect With',
                  style: normalStyle(color: lightSecondaryText),
                ),
                SizedBox(height: 20),
                MultiContainerRow(),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(
                      data: "Don't Have Account?",
                      style: legendStyle(color: lightPrimaryText),
                    ),
                    TextLink(
                      child: TextCustom(
                        data: "Sign Up Here",
                        style: legendStyle(color: lightLink),
                      ),
                      onTap: () {
                        navigateToNextPage(context, RegisterScreen());
                      },
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
