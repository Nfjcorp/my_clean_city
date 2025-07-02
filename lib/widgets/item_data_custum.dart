import 'package:flutter/material.dart';

class ItemDataCustum extends StatelessWidget {
  const ItemDataCustum({
    super.key,
    required this.image,
    required this.data,
    required this.tag,
  });

  final String image, data, tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Hero(
            tag: tag,
            child: Image.asset(height: 50, image, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          data,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'Robotto',
          ),
        ),
      ],
    );
  }
}
