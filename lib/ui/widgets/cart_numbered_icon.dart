import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:provider/provider.dart';

class CartNumberedIcon extends StatelessWidget {
  CartNumberedIcon({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyCartNotifier>(
      builder: (_, cartNotifier, __) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(
          child: Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: kDarkBlue,
                  size: getAdaptiveHeight(30, context),
                ),
                onPressed: onPressed,
              ),
              cartNotifier.cartLength == 0
                  ? Container()
                  : Stack(
                      children: <Widget>[
                        Icon(Icons.brightness_1,
                            size: getAdaptiveHeight(20, context),
                            color: kDarkOrange),
                        Container(
                          height: getAdaptiveHeight(20, context),
                          width: getAdaptiveHeight(20, context),
                          child: Center(
                            child: Text(
                              cartNotifier.cartLength.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getAdaptiveHeight(11, context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
