import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/core/models/order.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/data/cart.dart';
import 'package:my_shop_app/data_access/data/orders.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:toast/toast.dart';

class MyCartNotifier extends ChangeNotifier {
  List<CartItem> get items => cart;

  void addToCart(Product product, int quantity, BuildContext context) {
    final item = CartItem(
      productId: product.productId,
      quantity: quantity,
      unitPrice: product.price.toDouble(),
      price: (product.price * quantity).toDouble(),
    );
    cart.add(item);
    Toast.show(
      'Added To Cart Successfully!',
      context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
    );
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

  double totalPriceOf(List<CartItem> items) {
    double sum = 0;
    for (CartItem item in items) {
      sum += item.price;
    }
    return sum;
  }

  List<Order> get ordersItems => orders;
  int get ordersCount => orders.length;

  void checkOut() {
    orders.add(Order(
        orderId: DateTime.now().microsecondsSinceEpoch.toString(),
        items: cart.map((e) => e).toList(),
        orderDate: DateTime.now(),
        state: OrderState.Submitted,
        feedBack: null));

    cart.clear();
    notifyListeners();
  }
}
