import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = "/product-details-screen";

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('I am a prod'),
      ),
    );
  }
}
