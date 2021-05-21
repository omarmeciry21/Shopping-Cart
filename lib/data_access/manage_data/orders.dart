import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/core/models/order.dart';
import 'package:my_shop_app/core/models/orders.dart';
import 'package:my_shop_app/ui/constants.dart';

Orders orders =
    Orders(userId: FirebaseAuth.instance.currentUser.uid, ordersList: []);

Future<void> checkOut(Order order) async {
  try {
    orders.ordersList.add(order);

    List<Map<String, dynamic>> ordersAsMap = [];
    orders.ordersList.forEach(
      (element) {
        List<Map<String, dynamic>> orderItemsAsMap = [];
        element.items.forEach(
          (element) => orderItemsAsMap.add(
            {
              'itemId': element.itemId,
              'price': element.price,
              'productId': element.productId,
              'quantity': element.quantity,
              'unitPrice': element.unitPrice,
            },
          ),
        );

        ordersAsMap.add(
          {
            'orderId': element.orderId,
            'feedBack': element.feedBack,
            'items': orderItemsAsMap,
            'orderDate': element.orderDate,
            'stateIndex': element.state.index,
            'userId': element.userId
          },
        );
      },
    );
    await FirebaseFirestore.instance
        .collection('orders')
        .doc('${orders.userId}')
        .set({
      'userId': orders.userId,
      'orders': ordersAsMap,
    });
    await FirebaseFirestore.instance
        .collection('carts')
        .doc('${orders.userId}')
        .delete();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<List<Order>> getOrders() async {
  List<Order> orderList = [];
  try {
    DocumentSnapshot ordersData = await FirebaseFirestore.instance
        .collection('orders')
        .doc('${orders.userId}')
        .get();
    ordersData['orders'].forEach(
      (element) {
        List<CartItem> items = [];
        element['items'].forEach((item) => items.add(CartItem(
            itemId: item['itemId'],
            productId: item['productId'],
            quantity: item['quantity'],
            unitPrice: item['unitPrice'],
            price: item['price'])));

        Order order = Order(
          orderId: element['orderId'],
          userId: element['userId'],
          items: items,
          orderDate: element['orderDate'].toDate(),
          state: OrderState.values[element['stateIndex']],
          feedBack: element['feedBack'],
        );
        orderList.add(order);
      },
    );
  } catch (e) {
    print(e);
  }
  return orderList;
}

Future<void> fetchOrders() async {
  orders.ordersList = await getOrders();
}
