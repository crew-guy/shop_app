import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String routeName = "/products-overview";

  final List<Product> _loadedProducts = [
    Product(
      id: '1',
      title: 'p1',
      description: 'this is the description for product 1',
      price: 19.99,
      imgUrl: "https://unsplash.it/500",
    ),
    Product(
      id: '2',
      title: 'p2',
      description: 'this is the description for product 2',
      price: 29.99,
      imgUrl: "https://unsplash.it/501",
    ),
    Product(
      id: '3',
      title: 'p3',
      description: 'this is the description for product 3',
      price: 39.99,
      imgUrl: "https://unsplash.it/502",
    ),
    Product(
      id: '4',
      title: 'p4',
      description: 'this is the description for product 4',
      price: 49.99,
      imgUrl: "https://unsplash.it/503",
    ),
    Product(
      id: '5',
      title: 'p5',
      description: 'this is the description for product 5',
      price: 59.99,
      imgUrl: "https://unsplash.it/504",
    ),
    Product(
      id: '6',
      title: 'p6',
      description: 'this is the description for product 6',
      price: 69.99,
      imgUrl: "https://unsplash.it/505",
    ),
    Product(
      id: '7',
      title: 'p7',
      description: 'this is the description for product 7',
      price: 79.99,
      imgUrl: "https://unsplash.it/506",
    ),
    Product(
      id: '8',
      title: 'p8',
      description: 'this is the description for product 8',
      price: 79.99,
      imgUrl: "https://unsplash.it/508",
    ),
    Product(
      id: '9',
      title: 'p9',
      description: 'this is the description for product 9',
      price: 79.99,
      imgUrl: "https://unsplash.it/509",
    ),
    Product(
      id: '10',
      title: 'p10',
      description: 'this is the description for product 10',
      price: 109.99,
      imgUrl: "https://unsplash.it/510",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) {
          var currentLoadedProduct = _loadedProducts[i];
          return ProductItem(
            currentLoadedProduct.id,
            currentLoadedProduct.imgUrl,
            currentLoadedProduct.title,
          );
        },
        itemCount: _loadedProducts.length,
      ),
    );
  }
}
