import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String routeName = "/products-overview";
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
      ),
      body: ProductsGrid(),
    );
    return scaffold;
  }
}
