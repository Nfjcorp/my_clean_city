import 'package:flutter/material.dart';

class MyDraggableScrollable extends StatefulWidget {
  const MyDraggableScrollable({super.key});

  @override
  State<MyDraggableScrollable> createState() =>
      _DraggableScrollableCustomState();
}

class _DraggableScrollableCustomState extends State<MyDraggableScrollable> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Container(decoration: BoxDecoration(color: Colors.grey));
      },
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 1.0,
    );
  }
}
