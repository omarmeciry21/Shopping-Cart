import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/cart_item.dart';

class MyCartNotifier extends ChangeNotifier {
  List<CartItem> _cart = [];

  void addToCart(String productId, int quantity) {
    final item = CartItem(productId: productId, quantity: quantity);
    _cart.add(item);
    print(item);
    print(_cart.length);
    notifyListeners();
  }

  void removeCartItem(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void updateCartItem(CartItem oldItem, int newQuantity) {
    oldItem.quantity = newQuantity;
    notifyListeners();
  }

  int get cartLength => _cart.length;
}
