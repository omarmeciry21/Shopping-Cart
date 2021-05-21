import 'package:flutter/cupertino.dart';

class CartItem {
  int quantity;
  double price, unitPrice;
  final String productId, itemId;

  CartItem({
    @required this.itemId,
    @required this.productId,
    @required this.quantity,
    @required this.unitPrice,
    @required this.price,
  });
}
