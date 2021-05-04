import 'package:flutter/cupertino.dart';

class CartItem {
  int quantity;
  final String productId;

  CartItem({
    @required this.productId,
    @required this.quantity,
  });
}
