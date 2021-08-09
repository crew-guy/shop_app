import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text(
            '\$${orderItem.amount}',
            style: TextStyle(fontSize: 25.0),
          ),
          subtitle: Text(
            DateFormat('dd mm yyyy hh:mm').format(orderItem.time),
          ),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}
