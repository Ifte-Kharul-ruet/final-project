import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/user_products_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProducts ';
  const UserProductsScreen({Key? key}) : super(key: key);
  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndsetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName,
                  arguments: 'no');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].id,
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
