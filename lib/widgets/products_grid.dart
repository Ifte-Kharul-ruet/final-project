import 'package:my_shop/providers/products.dart';
import 'package:my_shop/widgets/product_item.dart';

//import '../models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(
        title: products[i].title,
        price: products[i].price,
        imageUrl: products[i].imageUrl,
        id: products[i].id,
      ),
    );
  }
}
