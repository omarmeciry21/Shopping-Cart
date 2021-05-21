import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/order.dart';

class Orders {
  String userId;
  List<Order> ordersList;

  Orders({@required this.userId, @required this.ordersList});

  Orders.clear({this.userId, this.ordersList});
}
