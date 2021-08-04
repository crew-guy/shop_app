import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String title;

  ProductItem(this.id, this.imgUrl, this.title);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(imgUrl, fit: BoxFit.cover),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
