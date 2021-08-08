import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final double price;
  final int quantity;
  final String id;

  CartItem({
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(
            child: Text('\$${price}'),
          ),
        ),
        title: Text(title),
        subtitle: Text('Total : ${quantity * price}'),
        trailing: Text(
          'x${quantity}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
