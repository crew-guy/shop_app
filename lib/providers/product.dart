import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imgUrl;
  final String description;
  final double price;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.description,
    required this.price,
    this.isFavourite = false,
  });

  void _setFavVal(bool value) {
    isFavourite = value;
  }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$token");
    var oldStatus = isFavourite;
    isFavourite = !isFavourite;
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        _setFavVal(oldStatus);
        notifyListeners();
        throw HttpException(message: 'Favourite status could not be updated');
      }
    } catch (error) {
      _setFavVal(oldStatus);
      throw HttpException(message: 'Favourite status could not be updated');
    }
    notifyListeners();
  }
}
