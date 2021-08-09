import 'package:shop_app/providers/cart.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime time;
  final List<CartItem> products;

  OrderItem({
    required this.id,
    required this.amount,
    required this.time,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addItem(List<CartItem> cartProducts, double amount) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: amount,
          time: DateTime.now(),
          products: cartProducts,
        ));
  }
}
