import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = "orders";
  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    // ordersData.fetchAndSetOrders();
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (dataSnapshot.error != null) {
                return Center(
                    child: Text('Error occurred while loading orders'));
              }
              return Consumer<Orders>(
                builder: (ctx,ordersData, child){
                  return ListView.builder(
                    itemCount:ordersData.orders.length,
                    itemBuilder:(ctx,i){
                      return OrderItem(ordersData.orders[i]);
                    }
                  );
                },
              );
        // ? Center(child: CircularProgressIndicator())
        // : ListView.builder(
        //     itemCount: ordersData.orders.length,
        //     itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
        //   ),
        );
  }
}
