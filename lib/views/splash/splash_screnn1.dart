import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/views/home/body_home.dart';
import 'package:my_clean_city/views/onboarding_screnn.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:provider/provider.dart';

class SplashScrenn extends StatefulWidget {
  const SplashScrenn({super.key});

  @override
  State<SplashScrenn> createState() => _SplashScrennState();
}

class _SplashScrennState extends State<SplashScrenn> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      final auth = Provider.of<AuthProviders>(context, listen: false);
      final user = auth.getCurrentUser();
      if (!mounted) return;
      if (user?.uid != null) {
        navigatePushReplacement(context, BodyHome());
      } else {
        navigatePushReplacement(context, OnboardingScrenn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/brands/logo_clean.png', width: 150),
            TextCustom(
              data: 'Reduce. Reuse. Recycle',
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            TextCustom(
              data: 'Repeat!',
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
