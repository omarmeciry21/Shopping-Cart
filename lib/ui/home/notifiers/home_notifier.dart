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

  List<Product> get featuredProducts =>
      products.where((element) => element.isFeatured == true).toList();

  List<Product> get selectedCategoryProducts =>
      categories[selectedIndex].categoryId == '###'
          ? products
          : products
              .where((element) =>
                  element.categoryId == categories[selectedIndex].categoryId)
              .toList();

  Product getProductAt(int index) => products.elementAt(index);
  Product getProductWithId(String productId) =>
      products.where((element) => element.productId == productId).first;
  List<Category> get categories => data.categories;
  List<Product> get products => dataProducts;
  List<Product> get favourites =>
      products.where((element) => element.isFavourite == true).toList();

  bool isFavourite(String productId) => products
      .where((element) => element.productId == productId)
      .first
      .isFavourite;

  Future<void> makeFavourite(String productId, BuildContext context) async {
    final bool currentState = products
        .where((element) => element.productId == productId)
        .first
        .isFavourite;
    if (currentState == true)
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Unfavourite Product'),
          content: Text('Are you sure you want to unfavourite this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'No',
              ),
            ),
            TextButton(
              onPressed: () {
                toggleFavourite(productId);
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    else
      toggleFavourite(productId);
  }

  void toggleFavourite(String productId) {
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
}
