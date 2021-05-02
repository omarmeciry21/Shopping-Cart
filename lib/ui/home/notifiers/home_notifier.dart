import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/category.dart';
import 'package:my_shop_app/core/models/featured.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/constants.dart';

class CategoryTabsNotifier extends ChangeNotifier {
  int selectedIndex = 0;
  void updateIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  final categories = [
    Category(categoryId: '###', title: 'All'),
    Category(categoryId: '101', title: 'Chairs'),
    Category(categoryId: '102', title: 'Handmade'),
  ];
  final products = [
    Product(
      productId: '1',
      title: 'Fashioned Chair',
      description: 'description description description',
      imageUrl:
          "https://www.vigfurniture.com/media/catalog/product/cache/1/image/1200x/17f82f742ffe127f42dca9de82fb58b1/7/6/76728_kenora_accent_chair_1.jpg",
      moneySymbol: '\$',
      categoryId: '101',
      price: 253,
      color: kDarkOrange,
    ),
    Product(
      productId: '2',
      title: 'Fashioned Chair2',
      description: 'description description description',
      imageUrl:
          "https://www.vigfurniture.com/media/catalog/product/cache/1/image/1200x/17f82f742ffe127f42dca9de82fb58b1/7/6/76728_kenora_accent_chair_1.jpg",
      moneySymbol: '\$',
      categoryId: '101',
      price: 253,
      color: Colors.blueAccent,
    ),
    Product(
      productId: '3',
      title: 'Fashioned Chair3',
      description: 'description description description',
      imageUrl:
          "https://www.vigfurniture.com/media/catalog/product/cache/1/image/1200x/17f82f742ffe127f42dca9de82fb58b1/7/6/76728_kenora_accent_chair_1.jpg",
      moneySymbol: '\$',
      categoryId: '102',
      price: 253,
      color: Colors.blueAccent,
    ),
    Product(
      productId: '4',
      title: 'Fashioned Chair4',
      description: 'description description description',
      imageUrl:
          "https://www.vigfurniture.com/media/catalog/product/cache/1/image/1200x/17f82f742ffe127f42dca9de82fb58b1/7/6/76728_kenora_accent_chair_1.jpg",
      moneySymbol: '\$',
      categoryId: '102',
      price: 253,
      color: Colors.blueAccent,
    ),
  ];

  final _featuredProducts = [
    Featured(
      productId: '3',
    ),
    Featured(
      productId: '1',
    ),
  ];

  List<Product> get featuredProducts {
    List<Product> items = [];
    for (Featured item in _featuredProducts) {
      items.add(products
          .where((element) => element.productId == item.productId)
          .first);
    }
    return items;
  }

  List<Product> get selectedCategoryProducts =>
      categories[selectedIndex].categoryId == '###'
          ? products
          : products
              .where((element) =>
                  element.categoryId == categories[selectedIndex].categoryId)
              .toList();
}
