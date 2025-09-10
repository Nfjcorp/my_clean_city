import 'package:flutter/material.dart';

class OnboardingContainer extends StatelessWidget {
  const OnboardingContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  final String imageUrl;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: 250),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
