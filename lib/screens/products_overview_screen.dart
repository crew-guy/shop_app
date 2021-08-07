import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = "/products-overview";

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavs = false;
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.Favorites) {
                // products.showFavouritesOnly();
                _showFavs = true;
              } else {
                // products.showAll();
                _showFavs = false;
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favorites,
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(_showFavs),
    );
    return scaffold;
  }
}
