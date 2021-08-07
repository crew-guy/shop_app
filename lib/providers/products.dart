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

  void addProduct() {
    notifyListeners();
  }
}
