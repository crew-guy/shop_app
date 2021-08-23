import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  // List<Product> _items = [
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imgUrl: 'https://unsplash.it/500',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imgUrl: 'https://unsplash.it/501',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imgUrl: 'https://unsplash.it/502',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imgUrl: 'https://unsplash.it/504',
  //   ),
  // ];
  List<Product> _items = [];
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

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products.json");
    try {
      var response = await http.get(url);
      Map<String, dynamic> productsFromDb = json.decode(response.body);
      final List<Product> loadedProducts = [];
      if (loadedProducts == null) {
        return;
      }
      productsFromDb.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            price: prodData['price'],
            imgUrl: prodData['imgUrl'],
            title: prodData['title'],
            description: prodData['description'],
            isFavourite: prodData['isFavourite'],
            id: prodId,
          ),
        );
        _items = loadedProducts;
      });
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products.json");

    try {
      var response = await http.post(
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
      );
      _items.add(
        Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imgUrl: product.imgUrl,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String productId, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == productId);
    var url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products/${productId}.json");
    if (prodIndex != null) {
      try {
        await http.patch(url, body: {
          'title': newProduct.title,
          'description': newProduct.description,
          'imgUrl': newProduct.imgUrl,
          'price': newProduct.price.toString(),
        });
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      print('Product update failed :(');
    }
    return Future.value();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products/${id}");
    final existingProductIndex = _items.indexWhere((prod) => id == prod.id);
    final existingProduct = _items[existingProductIndex];
    final response = await http.delete(url);
    print(response.statusCode);
    _items.removeAt(existingProductIndex);
    notifyListeners();
    if (response.statusCode >= 400) {
      existingProduct.dispose();
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: 'Could not delete product');
    }
  }
}
