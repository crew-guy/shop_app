import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';
import "package:provider/provider.dart";

class ProductsGrid extends StatelessWidget {
  bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavs ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) {
        var currentLoadedProduct = products[i];
        return ChangeNotifierProvider.value(
          value: currentLoadedProduct,
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
