import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import "package:provider/provider.dart";

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = "/product-details-screen";

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    final productsData = Provider.of<Products>(context, listen: false);
    final loadedProduct = productsData.findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
