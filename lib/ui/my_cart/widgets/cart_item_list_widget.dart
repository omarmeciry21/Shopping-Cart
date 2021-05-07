import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/outlined_icon_button.dart';
import 'package:provider/provider.dart';

class CartItemListWidget extends StatelessWidget {
  const CartItemListWidget({
    @required this.cartNotifier,
    @required this.index,
  });
  final cartNotifier;
  final index;
  @override
  Widget build(BuildContext context) {
    final currentProduct = Provider.of<HomeNotifier>(context)
        .getProductWithId(cartNotifier.items[index].productId);

    return Padding(
      padding: EdgeInsets.only(bottom: getAdaptiveHeight(20, context)),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
              iconWidget: Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30,
              ),
              caption: 'DELETE',
              color: Colors.redAccent,
              onTap: () {
                cartNotifier.removeCartItem(index);
              }),
        ],
        child: Container(
          height: getAdaptiveHeight(80, context),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getAdaptiveWidth(5, context),
                ),
                width: getAdaptiveHeight(75, context),
                height: getAdaptiveHeight(75, context),
                child: Image.network(currentProduct.imageUrl),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentProduct.title}',
                    style: kTitleTextStyle(context).copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: getAdaptiveHeight(5, context),
                  ),
                  Text(
                    '${currentProduct.moneySymbol}${currentProduct.price}',
                    style: kTitleTextStyle(context).copyWith(fontSize: 18),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getAdaptiveWidth(15, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedIconButton(
                      icon: Icons.remove,
                      containerDimensions: 15,
                      onPressed: () {
                        cartNotifier
                            .decreaseCartItem(cartNotifier.items[index]);
                      },
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(7, context),
                    ),
                    Text(
                      '${cartNotifier.items[index].quantity}',
                      style: kQuantityTextStyle(context).copyWith(
                        fontSize: getAdaptiveHeight(14, context),
                        color: kDarkBlue,
                      ),
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(7, context),
                    ),
                    OutlinedIconButton(
                      icon: Icons.add,
                      containerDimensions: 15,
                      color: kDarkBlue,
                      onPressed: () {
                        cartNotifier
                            .increaseCartItem(cartNotifier.items[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
