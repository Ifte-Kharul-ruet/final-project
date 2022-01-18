import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// import 'package:my_shop/providers/products.dart';
// import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  Favourites,

  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavouritesOnly = false;
  var _isInit = true;
  var _isLoading = false;
  // @override
  // void initState() {
  //   Provider.of<Products>(context).fetchAndsetProducts();
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndsetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    //final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodEnity Shop'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                value: cart.itemCount.toString()),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showFavouritesOnly = true;
                } else {
                  _showFavouritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavouritesOnly),
    );
  }
}
