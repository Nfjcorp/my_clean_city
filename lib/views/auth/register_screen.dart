import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/multi_container_row.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  final List<String> quartiers = [
    'Akwa',
    'NeW-Bell',
    'Nkongmondo',
    'Ndogpassi',
    'Nyalla'
        'Cité des palmiers'
        'Bounamoussadi',
    'Makepe',
    'Bonanjo',
    'Bali',
    'Bonaberi',
  ];

  String? _selectedQuartier;

  Future<void> _register() async {
    if (!formKey.currentState!.validate()) return;
    if (passwordController.text != confirmController.text) {
      showSnackBar(context, 'Les deux mots de passe doivent correspondre');
    }
    setState(() {
      loading = true;
    });
    try {
      debugPrint('object');
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final uid = userCredential.user!.uid;
      debugPrint('id des utilisateurs ');
      debugPrint('id des utilisateurs :${uid.toString()}');
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': 'citoyen',
        'quartier': _selectedQuartier,
        'points': 0,
        'createAt': FieldValue.serverTimestamp(),
      });
      debugPrint("object re");
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmController.clear();
      setState(() {
        _selectedQuartier = null;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Compte crée')));
      Navigator.pop(context);
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
                  child: Image.asset(height: 250, 'assets/images/signUp.png'),
                ),
                TextCustom(
                  data: 'Create Account',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5.0),
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
                      DropdownButtonFormField<String>(
                        value: _selectedQuartier,
                        items:
                            quartiers
                                .map(
                                  (city) => DropdownMenuItem(
                                    value: city,
                                    child: Text(city),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) =>
                                setState(() => _selectedQuartier = value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Choisissez un quartier',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null
                                    ? ' Veuillez Choisir un quartier'
                                    : null,
                      ),
                      SizedBox(height: 20),
                      TextFieldCustom(
                        controller: passwordController,
                        obscureText: isObscurePassword,
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscurePassword = !isObscurePassword;
                            });
                          },
                          icon:
                              isObscurePassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
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
                        obscureText: isObscureConfirmPassword,
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscureConfirmPassword =
                                  !isObscureConfirmPassword;
                            });
                          },
                          icon:
                              isObscureConfirmPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                loading
                    ? Scaffold(body: Center(child: CircularProgressIndicator()))
                    : ButtonCustom(
                      onTap: () => _register(),
                      child: Center(
                        child: TextCustom(
                          data: 'Sign Up',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Divider(height: 1, endIndent: 6, indent: 5),
                    ),
                    TextCustom(
                      data: 'Or Register With',
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
                    TextCustom(data: 'Already have an account? ', fontSize: 12),
                    InkWell(
                      onTap: widget.onTap,
                      child: TextCustom(
                        data: 'Login',
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
