import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    final provid = Provider.of<AuthProviders>(context);
    if (formKey.currentState!.validate()) return;
    try {
      await provid.resetPaswword(emailController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent'),
          duration: Duration(seconds: 2),
        ),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = provid.getCurrentUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  data: 'Paswword reinitialisation',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                TextCustom(
                  data: 'Email linked to your CleanCity account',
                  fontSize: 14,
                  color: Colors.grey,
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
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            ButtonCustom(
              onTap: resetPassword,
              child: Center(
                child: TextCustom(
                  data: 'continue',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
