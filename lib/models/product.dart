import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String? title;
  final String? imgUrl;
  final String? description;
  final double? price;
  bool? isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.imgUrl,
    @required this.description,
    @required this.price,
    @required this.isFavourite = false,
  });
}
