import 'package:flutter/cupertino.dart';

class CartItem {
  int quantity;
  double price, unitPrice;
  final String productId;

  CartItem({
    @required this.productId,
    @required this.quantity,
    @required this.unitPrice,
    @required this.price,
  });
}
