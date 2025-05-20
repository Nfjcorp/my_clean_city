import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/colors.dart';
import 'package:my_clean_city/core/utils/styles.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrimPassword = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('name'),
            SizedBox(height: 30),
            Text('Create New Password'),
            Text('Your'),
            FormCustom(
              formKey: formKey,
              child: Column(
                children: [
                  TextFieldCustom(
                    controller: passwordController,
                    labelText: 'Enter Your Password',
                    prefixIcon: Icon(Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your password';
                      } else if (value.length < 8) {
                        return 'password must be at least 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFieldCustom(
                    controller: confrimPassword,
                    labelText: 'Confirm Your Password',
                    prefixIcon: Icon(Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your password';
                      } else if (value.length < 8) {
                        return 'password must be at least 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 30),
                  ButtonCustom(
                    onTap: () {},
                    child: TextCustom(
                      data: 'Resend',
                      style: buttonStyle(color: whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
