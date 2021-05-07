import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/data/cart.dart';

class MyCartNotifier extends ChangeNotifier {
  List<CartItem> get items => cart;

  void addToCart(Product product, int quantity) {
    final item = CartItem(
      productId: product.productId,
      quantity: quantity,
      unitPrice: product.price.toDouble(),
      price: (product.price * quantity).toDouble(),
    );
    cart.add(item);
    print(item);
    print(cart.length);
    notifyListeners();
  }

  void removeCartItem(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  void updateCartItem(CartItem oldItem, int newQuantity) {
    oldItem.quantity = newQuantity;
    oldItem.price = oldItem.quantity * oldItem.unitPrice;
    notifyListeners();
  }

  void increaseCartItem(CartItem oldItem) {
    if (oldItem.quantity >= 50) return;
    oldItem.quantity++;
    oldItem.price = oldItem.quantity * oldItem.unitPrice;
    notifyListeners();
  }

  void decreaseCartItem(CartItem oldItem) {
    if (oldItem.quantity <= 1) return;
    oldItem.quantity--;
    oldItem.price = oldItem.quantity * oldItem.unitPrice;
    notifyListeners();
  }

  int get cartLength => cart.length;

  double get totalPrice {
    double sum = 0;
    for (CartItem item in cart) {
      sum += item.price;
    }
    return sum;
  }
}
