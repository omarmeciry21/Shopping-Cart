import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/cart_item.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderSummaryList extends StatelessWidget {
  OrderSummaryList(
      {Key key, @required this.items, this.startingWidgets, this.endingWidgets})
      : super(key: key);

  final List<CartItem> items;
  Widget startingWidgets, endingWidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kContainerBoxDecoration(context),
      padding: EdgeInsets.all(getAdaptiveHeight(15, context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          startingWidgets == null ? Container() : startingWidgets,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: kScreenTitleTextStyle(context),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getAdaptiveHeight(10, context),
                    vertical: getAdaptiveHeight(5, context),
                  ),
                  decoration: BoxDecoration(
                      color: kDarkBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(
                          getAdaptiveHeight(20, context))),
                  child: Text(
                    'Total: ${Provider.of<MyCartNotifier>(context).totalPriceOf(items)}',
                    style: kScreenTitleTextStyle(context).copyWith(
                      fontSize: getAdaptiveHeight(14, context),
                      color: kDarkBlue.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: getAdaptiveWidth(25, context),
                right: getAdaptiveWidth(10, context),
                top: getAdaptiveHeight(10, context)),
            child: Column(
              children: _buildItemsList(items, context),
            ),
          ),
          endingWidgets == null ? Container() : endingWidgets
        ],
      ),
    );
  }
}

List<Widget> _buildItemsList(List<CartItem> items, BuildContext context) {
  List<Widget> widgets = [];
  items.forEach(
    (cartItem) {
      final currentProduct = Provider.of<HomeNotifier>(context)
          .getProductWithId(cartItem.productId);
      widgets.add(
        _buildSingleLineOrderItem(
          title: currentProduct.title,
          price: currentProduct.price,
          quantity: cartItem.quantity,
          moneySign: currentProduct.moneySymbol,
          context: context,
        ),
      );
    },
  );
  return widgets;
}

Widget _buildSingleLineOrderItem(
    {@required title,
    @required price,
    @required quantity,
    @required moneySign,
    @required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(top: getAdaptiveHeight(5, context)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            '$title',
            style: kSingleLineTextStyle(context),
          ),
        ),
        Text(
          '$moneySign$price x $quantity',
          style: kSingleLineTextStyle(context),
        )
      ],
    ),
  );
}
