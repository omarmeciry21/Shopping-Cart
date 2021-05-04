import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/data/products.dart';

class FavouritesNotifier extends ChangeNotifier {
  List<Product> favourites =
      products.where((element) => element.isFavourite == true).toList();

  bool isFavourite(String productId) => products
      .where((element) => element.productId == productId)
      .first
      .isFavourite;

  void makeFavourite(String productId) {
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
