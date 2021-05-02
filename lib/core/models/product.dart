import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';

class Product {
  final String productId, title, description, imageUrl, moneySymbol, categoryId;
  final num price;
  final Color color;

  Product({
    @required this.productId,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.moneySymbol,
    @required this.categoryId,
    @required this.price,
    @required this.color,
  });
}
