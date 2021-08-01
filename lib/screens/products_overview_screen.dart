import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> _loadedProducts = [
    Product(
        id: '1',
        title: 'p1',
        description: 'this is the description for product 1',
        imgUrl:
            "https://cdn.pixabay.com/photo/2015/03/26/09/41/chain-690088__340.jpg")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products overview'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) {
          return Container();
        },
        itemCount: 10,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
