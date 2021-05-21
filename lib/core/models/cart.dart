import 'package:flutter/foundation.dart';
import 'package:my_shop_app/core/models/cart_item.dart';

class Cart {
  String userId;
  List<CartItem> cartItems;

  Cart({@required this.userId, @required this.cartItems});
  Cart.clear({this.userId, this.cartItems});
}
