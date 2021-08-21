import 'dart:convert';
import 'package:shop_app/providers/cart.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

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

  Future<void> fetchAndSetOrders() {}

  Future<void> addItem(List<CartItem> cartProducts, double amount) async {
    var url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/orders.json");
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': amount,
            'time': DateTime.now(),
            'products': cartProducts
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: amount,
          time: DateTime.now(),
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
