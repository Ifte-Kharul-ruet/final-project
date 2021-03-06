import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(
      {required String? productId,
      required double price,
      required String title}) {
    if (productId != null) {
      if (_items.containsKey(productId)) {
        _items.update(
            productId,
            (exsistingCartItem) => CartItem(
                  id: exsistingCartItem.id,
                  title: exsistingCartItem.title,
                  quantity: exsistingCartItem.quantity + 1,
                  price: exsistingCartItem.price,
                ));
      } else {
        _items.putIfAbsent(
            productId,
            () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price));
      }
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String? productID) {
    if (!_items.containsKey(productID)) {
      return;
    }
    if (productID != null) {
      if (_items[productID]!.quantity > 1) {
        _items.update(
            productID,
            (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price));
      } else {
        _items.remove(productID);
      }
    }
    notifyListeners();
  }
}
