import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/ui/constants.dart';

class Order {
  final List<CartItem> items;
  final String orderId;
  String feedBack;
  final DateTime orderDate;
  OrderState state;

  Order({
    @required this.orderId,
    @required this.items,
    @required this.orderDate,
    @required this.state,
    @required this.feedBack,
  });
}
