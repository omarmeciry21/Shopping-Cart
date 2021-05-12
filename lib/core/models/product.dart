import 'package:flutter/material.dart';

class Product {
  final String productId, title, description, imageUrl, moneySymbol, categoryId;
  final num price;
  final Color color;
  bool isFavourite, isFeatured;

  Product({
    @required this.productId,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.moneySymbol,
    @required this.categoryId,
    @required this.price,
    @required this.color,
    this.isFeatured = false,
    this.isFavourite = false,
  });
}
