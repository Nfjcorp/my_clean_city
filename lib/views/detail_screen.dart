import 'package:flutter/material.dart';
import 'package:my_clean_city/models/item_model.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.item});

  final ItemModel item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustom(
          data: widget.item.name,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Hero(
              tag: widget.item.name,
              child: Center(
                child: Image.asset(widget.item.imagePath, fit: BoxFit.cover),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                TextCustom(
                  data: 'A TRIER',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                TextCustom(
                  data: 'Bac au couvercle ${widget.item.color}',
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  data: 'Méthode de tri',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                TextCustom(
                  data: widget.item.description,
                  fontSize: 16,
                  color: Colors.grey,
                ),
                SizedBox(height: 20.0),
                TextCustom(
                  data: 'Le saviez-vous ?',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                TextCustom(data: widget.item.about, fontSize: 14, color: Colors.grey,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
