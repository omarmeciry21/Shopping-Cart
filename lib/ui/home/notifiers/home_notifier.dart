import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/category.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/data/categories.dart' as data;
import 'package:my_shop_app/data_access/manage_data/products.dart';

class HomeNotifier extends ChangeNotifier {
  int selectedIndex = 0;

  void updateIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  List<Product> get featuredProducts => dataProductsFeatured;

  List<Product> get selectedCategoryProducts =>
      categories[selectedIndex].categoryId == '###'
          ? products
          : products
              .where((element) =>
                  element.categoryId == categories[selectedIndex].categoryId)
              .toList();

  Product getProductWithId(String productId) =>
      products.where((element) => element.productId == productId).first;
  List<Category> get categories => data.categories;
  List<Product> get products => dataProducts;
  List<Product> get favourites => dataProductsFavourites;

  bool isFavourite(String productId) => products
      .where((element) => element.productId == productId)
      .first
      .isFavourite;

  void toggleFavouriteButton(String productId) async {
    await toggleFavourite(productId);
    products
            .where((element) => element.productId == productId)
            .first
            .isFavourite =
        !products
            .where((element) => element.productId == productId)
            .first
            .isFavourite;

    notifyListeners();
  }

  bool isSearching = false;

  toggleSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }
}
