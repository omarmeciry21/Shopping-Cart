import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/core/models/order.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/manage_data/cart.dart' as manageCart;
import 'package:my_shop_app/data_access/manage_data/orders.dart'
    as manageOrders;
import 'package:my_shop_app/ui/constants.dart';
import 'package:toast/toast.dart';

class MyCartNotifier extends ChangeNotifier {
  List<CartItem> get items => manageCart.cart.cartItems;

  void addToCart(Product product, int quantity, BuildContext context) {
    final item = CartItem(
      itemId: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: product.productId,
      quantity: quantity,
      unitPrice: product.price.toDouble(),
      price: (product.price * quantity).toDouble(),
    );
    manageCart.addToCart(item);
    Toast.show(
      'Added To Cart Successfully!',
      context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: Colors.green.withOpacity(0.75),
    );
    notifyListeners();
  }

  void removeCartItem(int index) {
    manageCart.removeFromCart(manageCart.cart.cartItems[index]);
    notifyListeners();
  }

  void updateCartItem(CartItem oldItem, int newQuantity) {
    manageCart.updateCartItem(oldItem, newQuantity);
    notifyListeners();
  }

  void increaseCartItem(CartItem oldItem) {
    if (oldItem.quantity >= 50) return;
    updateCartItem(oldItem, ++oldItem.quantity);
    notifyListeners();
  }

  void decreaseCartItem(CartItem oldItem) {
    if (oldItem.quantity <= 1) return;
    manageCart.updateCartItem(oldItem, --oldItem.quantity);
    notifyListeners();
  }

  int get cartLength => manageCart.cart.cartItems.length;

  double get totalPrice {
    double sum = 0;
    for (CartItem item in manageCart.cart.cartItems) {
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

  List<Order> get ordersItems => manageOrders.orders.ordersList;
  int get ordersCount => manageOrders.orders.ordersList.length;

  void checkOut() async {
    Order newOrder = Order(
      orderId: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: manageOrders.orders.userId,
      items: manageCart.cart.cartItems,
      orderDate: DateTime.now(),
      state: OrderState.Submitted,
      feedBack: null,
    );
    await manageOrders.checkOut(newOrder);
    manageCart.cart.cartItems.clear();
    notifyListeners();
  }
}
