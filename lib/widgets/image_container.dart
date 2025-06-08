import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.imagePath, this.width});

  final String imagePath;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green),
      ),
      child: Image.asset(imagePath),
    );
  }
}
