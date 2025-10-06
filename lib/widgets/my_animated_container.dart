import 'package:flutter/material.dart';

class MyAnimatedContainer extends StatelessWidget {
  const MyAnimatedContainer({
    super.key,
    required this.nbre,
    required this.index,
    required this.currentIndex,
  });

  final int nbre, index, currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(nbre, (index) => buildContainer(index: index)),
    );
  }

  AnimatedContainer buildContainer({required int index}) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 2),
      duration: Duration(milliseconds: 2),
      height: currentIndex == index ? 16 : 8,
      width: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: currentIndex == index ? Colors.green.shade400 : Colors.green,
      ),
    );
  }
}
