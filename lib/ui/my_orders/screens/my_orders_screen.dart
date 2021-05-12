import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/single_order_summary.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedRoundedIconButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Orders',
          style: kScreenTitleTextStyle(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: kScreenPadding(context),
          child: ListView.builder(
              itemCount: Provider.of<MyCartNotifier>(context).ordersCount,
              itemBuilder: (context, index) {
                final currentOrder =
                    Provider.of<MyCartNotifier>(context).ordersItems[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getAdaptiveHeight(10, context)),
                  child: OrderSummaryList(
                    cartItems: currentOrder.items,
                    startingWidgets: Padding(
                      padding: EdgeInsets.only(
                          bottom: getAdaptiveHeight(10, context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Order Date: ${DateFormat('yyyy-MM-dd | kk:mm').format(currentOrder.orderDate)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    endingWidgets: Padding(
                      padding:
                          EdgeInsets.only(top: getAdaptiveHeight(20, context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID: ${currentOrder.orderId}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kDarkBlue.withOpacity(0.7)),
                          ),
                          getOrderStateIcon(currentOrder.state, context),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

// ignore: missing_return
Widget getOrderStateIcon(OrderState state, BuildContext context) {
  switch (state) {
    case OrderState.Submitted:
      return OrderStateIcon(title: 'Submitted', color: Colors.yellow[800]);
      break;
    case OrderState.InProgress:
      return OrderStateIcon(title: 'InProgress', color: Colors.blue[800]);
      break;
    case OrderState.Failed:
      return OrderStateIcon(title: 'UnSuccessful', color: Colors.black);
      break;
    case OrderState.Delivered:
      return OrderStateIcon(title: 'Delivered', color: Colors.green[800]);
      break;
    case OrderState.Canceled:
      return OrderStateIcon(title: 'Canceled', color: Colors.red[800]);
      break;
  }
}

class OrderStateIcon extends StatelessWidget {
  const OrderStateIcon({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  final color, title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: getAdaptiveHeight(3, context),
        ),
        SizedBox(
          width: getAdaptiveWidth(4, context),
        ),
        Text(
          '$title',
          style: TextStyle(
              color: color,
              fontSize: getAdaptiveHeight(12, context),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
