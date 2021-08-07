import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import "package:provider/provider.dart";

class ProductItem extends StatelessWidget {
  // final String id;
  // final String imgUrl;
  // final String title;

  ProductItem(
      // this.id,
      // this.imgUrl,
      // this.title,
      );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 2.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              2, // Move to right 2  horizontally
              2, // Move to bottom 2 Vertically
            ),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailsScreen.routeName,
                arguments: product.id),
            // child: Image.network(product.imgUrl, fit: BoxFit.cover),
            child: Container(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline),
                onPressed: () {
                  product.toggleFavouriteStatus();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.price,
                    product.title,
                  );
                },
                color: Theme.of(context).accentColor),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
