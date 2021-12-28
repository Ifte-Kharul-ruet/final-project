import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  // final String title;
  // final double price;
  // final String imageUrl;
  // final String id;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: GridTileBar(
          //backgroundColor: Colors.black38,
          title: Text(
            '\$ ${product.price}',
            style: const TextStyle(backgroundColor: Colors.black38),
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {
              product.toogleFavouriteStatus();
            },
            icon: Icon(
              product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ),
      ),
    );
  }
}
