import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';

class CartNumberedIcon extends StatelessWidget {
  CartNumberedIcon(
      {Key key, @required this.onPressed, @required this.cartNotifier})
      : super(key: key);
  final Function onPressed;
  final cartNotifier;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: kDarkBlue,
                size: 30,
              ),
              onPressed: onPressed,
            ),
            cartNotifier.cartLength == 0
                ? Container()
                : Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 20.0, color: kDarkOrange),
                      Container(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: Text(
                            cartNotifier.cartLength.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.0,
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
    );
  }
}
