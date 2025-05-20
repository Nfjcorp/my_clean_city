import 'package:flutter/material.dart';
import 'package:my_clean_city/widgets/image_container.dart';

class MultiContainerRow extends StatelessWidget {
  const MultiContainerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageContainer(imagePath: 'assets/icons/google.png'),
        SizedBox(width: 20),
        ImageContainer(imagePath: 'assets/icons/facebook.png'),
        SizedBox(width: 20),
        ImageContainer(imagePath: 'assets/icons/apple.png'),
      ],
    );
  }
}
