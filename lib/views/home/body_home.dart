import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/styles.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextCustom(
                    data: 'Hello,',
                    style: displayLarge(
                      24,
                      'Robotto',
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  TextCustom(
                    data: 'Junior',
                    style: displaySmall(color: Colors.green),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset('assets/icons/apple.png'),
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
