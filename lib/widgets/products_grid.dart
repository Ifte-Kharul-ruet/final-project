import 'package:my_shop/providers/products.dart';
import 'package:my_shop/widgets/product_item.dart';

//import '../models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  // ignore: use_key_in_widget_constructors
  const ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        (showFavs == true) ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
      ),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const ProductItem(
            // title: products[i].title,
            // price: products[i].price,
            // imageUrl: products[i].imageUrl,
            // id: products[i].id,
            ),
      ),
    );
  }
}
