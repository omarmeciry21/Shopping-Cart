import 'package:flutter/cupertino.dart';

class Category {
  final String categoryId, title, imageUrl;
  final color;

  Category({
    @required this.categoryId,
    @required this.title,
    @required this.color,
    @required this.imageUrl,
  });
}
