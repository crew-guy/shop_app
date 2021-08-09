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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '\$${loadedProduct.price}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 10),
            Text(
              loadedProduct.description,
              style: TextStyle(color: Theme.of(context).accentColor),
              // softWrap: true,
            ),
          ]),
        ));
  }
}
