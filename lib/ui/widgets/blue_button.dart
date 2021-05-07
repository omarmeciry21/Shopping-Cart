import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getAdaptiveHeight(45, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kDarkBlue,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
