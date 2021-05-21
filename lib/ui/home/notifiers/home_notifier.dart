import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/category.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/manage_data/cart.dart';
import 'package:my_shop_app/data_access/manage_data/categories.dart' as data;
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
  List<String> get favouritesIdList => favouritesId;

  void toggleFavouriteButton(String productId) async {
    await toggleFavourite(productId);

    if (favouritesId.contains(productId)) {
      dataProductsFavourites.removeAt(dataProductsFavourites.indexOf(
          dataProductsFavourites
              .where((element) => element.productId == productId)
              .first));
      dataProducts
          .where((element) => element.productId == productId)
          .first
          .isFavourite = false;
      favouritesId.removeAt(favouritesId.indexOf(
          favouritesId.where((element) => element == productId).first));
    } else {
      dataProductsFavourites.add(dataProducts
          .where((element) => element.productId == productId)
          .toList()
          .first);
      dataProducts
          .where((element) => element.productId == productId)
          .first
          .isFavourite = true;
      favouritesId.add(productId);
    }
    notifyListeners();
  }

  bool isSearching = false;

  toggleSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  String searchText = '';
  List<Product> filteredProducts = [];

  void clearSearchingData() {
    searchText = '';
    filteredProducts = [];
    notifyListeners();
  }

  void updateSearchText(String text, List<Product> list) {
    searchText = text;
    filteredProducts = list;
    notifyListeners();
  }

  void refreshHomePage() async {
    await fetchProducts();
    await fetchFavourites();
    await fetchFeatured();
    await data.fetchCategories();
    try {
      await fetchCartItems();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
