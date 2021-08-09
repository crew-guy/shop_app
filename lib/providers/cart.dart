import 'package:flutter/material.dart';

class CartItem {
  final String? id;
  final double? price;
  final int? quantity;
  final String? title;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get cartItems {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    bool doesItemExist = _items.containsKey(productId);
    if (doesItemExist) {
      // update quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          title: existingCartItem.title,
          id: existingCartItem.id,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity! + 1,
        ),
      );
    } else {
      //add item to list
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  double get totalAmount {
    double totalAmount = 0.0;
    _items.forEach((key, item) {
      totalAmount += item.price! * item.quantity!;
    });
    return totalAmount;
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
