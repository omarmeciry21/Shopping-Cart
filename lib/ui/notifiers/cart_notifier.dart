import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/data_access/data/cart.dart';

class MyCartNotifier extends ChangeNotifier {
  List get cartItems => cart;
  void addToCart(String productId, int quantity) {
    cart.add(CartItem(productId: productId, quantity: quantity));
    notifyListeners();
  }

  void removeCartItem(CartItem item) {
    cart.remove(item);
    notifyListeners();
  }

  void updateCartItem(CartItem oldItem, int newQuantity) {
    oldItem.quantity = newQuantity;
    notifyListeners();
  }

  int get cartLength => cart.length;
}
