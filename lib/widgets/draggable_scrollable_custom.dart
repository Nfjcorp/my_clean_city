import 'package:flutter/material.dart';

class DraggableScrollableCustom extends StatefulWidget {
  const DraggableScrollableCustom({super.key});

  @override
  State<DraggableScrollableCustom> createState() =>
      _DraggableScrollableCustomState();
}

class _DraggableScrollableCustomState extends State<DraggableScrollableCustom> {
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
