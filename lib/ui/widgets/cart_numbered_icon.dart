import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';

class CartNumberedIcon extends StatelessWidget {
  const CartNumberedIcon({
    Key key,
    @required this.listLength,
    @required this.onPressed,
  }) : super(key: key);

  final int listLength;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        child: GestureDetector(
          onTap: onPressed,
          child: Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: kDarkBlue,
                  size: 30,
                ),
                onPressed: null,
              ),
              listLength == 0
                  ? Container()
                  : Stack(
                      children: <Widget>[
                        Icon(Icons.brightness_1,
                            size: 20.0, color: kDarkOrange),
                        Container(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: Text(
                              listLength.toString(),
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
      ),
    );
  }
}
