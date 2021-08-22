import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import "package:shop_app/widgets/cart_item.dart";

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    var cartItemsData = Provider.of<Cart>(context);
    var cartItems = cartItemsData.cartItems;
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).accentColor,
                    label: Text(
                      '\$${cartItemsData.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text('ORDER NOW'),
                    onPressed: cartItemsData.totalAmount <= 0
                        ? null
                        : () {
                            Provider.of<Orders>(context, listen: false).addItem(
                                cartItemsData.cartItems.values.toList(),
                                cartItemsData.totalAmount);
                            cartItems.clear();
                            // Navigator.of(context).pushNamed(OrdersScreen.routeName);
                          },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (ctx, i) {
                  var currentCartItem = cartItems.values.toList()[i];
                  return CartItem(
                    id: currentCartItem.id!,
                    productId: cartItems.keys.toList()[i],
                    title: currentCartItem.title!,
                    price: currentCartItem.price!,
                    quantity: currentCartItem.quantity!,
                  );
                },
                itemCount: cartItems.length),
          )
        ],
      ),
    );
  }
}
