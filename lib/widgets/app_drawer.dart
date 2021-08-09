import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Hey Customer !'),
        ),
        Divider(),
        ListTile(
          title: Text('Shop'),
          leading: Icon(Icons.shopping_cart),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          title: Text('Payment'),
          leading: Icon(Icons.payment),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
        )
      ],
    ));
  }
}
