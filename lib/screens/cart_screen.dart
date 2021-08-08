import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shop_app/providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    var cartItemsData = Provider.of<Cart>(context);
    var cartItems = cartItemsData.cartItems;
    return Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Text('Total', style: TextStyle(fontSize: 20)),
                    Chip(
                      label: Text(cartItemsData.totalAmount.toString()),
                    )
                  ])))
        ]));
  }
}
