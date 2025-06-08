import 'package:flutter/material.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class SplashScrenn2 extends StatefulWidget {
  const SplashScrenn2({super.key, required this.page});

  final Widget page;

  @override
  State<SplashScrenn2> createState() => _SplashScrenn2State();
}

class _SplashScrenn2State extends State<SplashScrenn2> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 99, 199, 102),
      body: Center(
        child: Column(
          children: [
            Image.asset('name'),
            TextCustom(data: 'data', fontSize: 14),
          ],
        ),
      ),
    );
  }
}
