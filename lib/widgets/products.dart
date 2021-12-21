import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  const Products({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
