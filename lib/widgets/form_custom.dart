import 'package:flutter/material.dart';

class FormCustom extends StatelessWidget {
  const FormCustom({super.key, required this.formKey, required this.child});

  final GlobalKey<FormState> formKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: child);
  }
}
