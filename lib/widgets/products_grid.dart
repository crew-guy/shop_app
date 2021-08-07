import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';
import "package:provider/provider.dart";

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) {
        var currentLoadedProduct = products[i];
        return ChangeNotifierProvider(
          create: (ctx) => currentLoadedProduct,
          child: ProductItem(
              // currentLoadedProduct.id,
              // currentLoadedProduct.imgUrl,
              // currentLoadedProduct.title,
              ),
        );
      },
      itemCount: products.length,
    );
  }
}
