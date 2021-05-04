import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/products.dart';

class FavouritesNotifier extends ChangeNotifier {
  List<Product> favourites =
      products.where((element) => element.isFavourite == true).toList();

  bool isFavourite(String productId) => favourites.contains(
      products.where((element) => element.productId == productId).first);

  void makeFavourite(String productId) {}
}
