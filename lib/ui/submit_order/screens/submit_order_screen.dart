import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/blue_button.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/single_order_summary.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SubmitOrderScreen extends StatelessWidget {
  SubmitOrderScreen({@required this.cartItems});
  final List<CartItem> cartItems;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: ElevatedRoundedIconButton(
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Submit Order',
          style: kScreenTitleTextStyle(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: kScreenPadding(context),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    OrderSummaryList(cartItems: cartItems),
                    SizedBox(
                      height: getAdaptiveHeight(15, context),
                    ),
                    PaymentOptionsBox(),
                  ],
                ),
              ),
              Expanded(child: Container()),
              BlueButton(
                text: 'Submit Order',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Submit Order'),
                      content:
                          Text('Are you sure you want to submit this order?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<MyCartNotifier>(context, listen: false)
                                .checkOut();

                            Toast.show(
                              'Order Submitted Successfully!',
                              context,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor: Colors.green,
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionsBox extends StatelessWidget {
  const PaymentOptionsBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getAdaptiveHeight(15, context)),
      decoration: kContainerBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment',
            style: kScreenTitleTextStyle(context),
          ),
          SizedBox(
            height: getAdaptiveHeight(10, context),
          ),
          Row(
            children: [
              Icon(
                Icons.money_rounded,
                color: kDarkOrange.withOpacity(0.8),
                size: getAdaptiveHeight(30, context),
              ),
              SizedBox(
                width: getAdaptiveWidth(10, context),
              ),
              Text(
                'Payment on Delivery',
                style: kScreenTitleTextStyle(context).copyWith(
                    fontSize: 18, color: Colors.black87.withOpacity(0.7)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
