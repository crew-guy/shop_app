import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder: (_, i) {
          final currentProduct = productsData.items[i];
          return UserProductItem(
            title: currentProduct.title,
            imgUrl: currentProduct.imgUrl,
          );
        },
      ),
    );
  }
}
