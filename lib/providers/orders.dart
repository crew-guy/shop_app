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
  final String BASE_URL =
      "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com";

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse('${BASE_URL}/orders.json');
    final loadedOrders = [];
    try {
      final response = await http.get(url);
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addItem(List<CartItem> cartProducts, double amount) async {
    var url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/orders.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': amount,
            'time': DateTime.now().toIso8601String(),
            'products': cartProducts
                .map((cartItem) => {
                      'price': cartItem.price,
                      'title': cartItem.title,
                      'quantity': cartItem.quantity,
                      'id': cartItem.id
                    })
                .toList()
          },
        ),
      );
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
