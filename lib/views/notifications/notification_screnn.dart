import 'package:flutter/material.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class NotificationScrenn extends StatelessWidget {
  const NotificationScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(data: 'Favorite', fontSize: 15),
        centerTitle: true,
      ),
    );
  }
}
