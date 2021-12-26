import 'package:flutter/material.dart';
import 'package:my_shop/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  final String id;
  const ProductItem({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
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
          trailing: IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ),
      ),
    );
  }
}
