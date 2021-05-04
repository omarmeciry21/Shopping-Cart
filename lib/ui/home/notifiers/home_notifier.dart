import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/category.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/categories.dart' as data;
import 'package:my_shop_app/ui/products.dart' as data;

class CategoryTabsNotifier extends ChangeNotifier {
  int selectedIndex = 0;
  void updateIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  List<Product> get featuredProducts =>
      products.where((element) => element.isFeatured == true).toList();

  List<Product> get selectedCategoryProducts =>
      categories[selectedIndex].categoryId == '###'
          ? products
          : products
              .where((element) =>
                  element.categoryId == categories[selectedIndex].categoryId)
              .toList();
  List<Category> get categories => data.categories;
  List<Product> get products => data.products;
}
