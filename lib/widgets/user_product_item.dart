import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  UserProductItem({
    required this.title,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductsScreen.routeName);
              },
              color: Theme.of(context).accentColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
