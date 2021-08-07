import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String title;

  ProductItem(this.id, this.imgUrl, this.title);

  @override
  Widget build(BuildContext context) {
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
              onTap: () => Navigator.of(context)
                  .pushNamed(ProductDetailsScreen.routeName, arguments: id),
              child: Image.network(imgUrl, fit: BoxFit.cover)),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
                color: Theme.of(context).accentColor),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
