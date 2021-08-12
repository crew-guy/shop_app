import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgUrl: 'https://unsplash.it/500',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imgUrl: 'https://unsplash.it/501',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imgUrl: 'https://unsplash.it/502',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imgUrl: 'https://unsplash.it/504',
    ),
  ];
  var _showFavourites = false;

  List<Product> get items {
    // if (_showFavourites) {
    // return [...items.where((prod) => prod.isFavourite)];
    // }
    return [..._items];
  }

  void showFavouritesOnly() {
    _showFavourites = true;
    notifyListeners();
  }

  void showAll() {
    _showFavourites = false;
    notifyListeners();
  }

  List<Product> get favouriteItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((product) => product.id == productId);
  }

  void addProduct(Product product) {
    var url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products.json");
    http
        .post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'imgUrl': product.imgUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        },
      ),
    )
        .then((res) {
      _items.add(Product(
        id: json.decode(res.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        imgUrl: product.imgUrl,
      ));
      notifyListeners();
    });
  }

  void updateProduct(String productId, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == productId);
    if (prodIndex != null) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('Product update failed :(');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
