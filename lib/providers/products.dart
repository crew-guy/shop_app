import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  var _showFavourites = false;
  final String? authToken;
  final String? userId;
  List<Product> get items {
    // if (_showFavourites) {
    // return [...items.where((prod) => prod.isFavourite)];
    // }
    return [..._items];
  }

  Products(this.authToken, this.userId, this._items);

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
        'https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"');
    try {
      var response = await http.get(url);
      Map<String, dynamic> productsFromDb = json.decode(response.body);
      final List<Product> loadedProducts = [];
      if (loadedProducts == null) {
        return;
      }
      url = Uri.parse(
          "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken");
      final favouriteResponse = await http.get(url);
      final favouriteResponseData = json.decode(favouriteResponse.body);
      productsFromDb.forEach((prodId, prodData) async {
        loadedProducts.add(
          Product(
            price: prodData['price'],
            imgUrl: prodData['imgUrl'],
            title: prodData['title'],
            description: prodData['description'],
            isFavourite: favouriteResponseData == null
                ? false
                : favouriteResponseData[prodId]['isFavourite'] ?? false,
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
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products.json?auth=$authToken");

    try {
      var response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imgUrl': product.imgUrl,
            'price': product.price,
            'creatorId': userId
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
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products/${productId}.json?auth=$authToken");
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
        "https://flutter-shop-app-79b4d-default-rtdb.firebaseio.com/products/${id}?auth=$authToken");
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
