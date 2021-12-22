import 'package:flutter/material.dart';
import 'package:my_shop/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Shop',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.amber),
      ),
      home: ProductOverviewScreen(),
    );
  }
}
