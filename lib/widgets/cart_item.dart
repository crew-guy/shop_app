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
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15.0,
        ),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text('\$${price}'),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total : ${quantity * price}'),
              trailing: Text(
                'x${quantity}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
