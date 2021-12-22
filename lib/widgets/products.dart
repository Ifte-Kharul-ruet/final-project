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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        header: GridTileBar(
          //backgroundColor: Colors.black38,
          title: Text(
            '\$ $price',
            style: const TextStyle(backgroundColor: Colors.black38),
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              //color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          backgroundColor: Colors.black54,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing:
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ),
      ),
    );
  }
}
