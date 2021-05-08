import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

class ElevatedRoundedIconButton extends StatelessWidget {
  const ElevatedRoundedIconButton(
      {Key key,
      this.icon = Icons.arrow_back,
      @required this.onPressed,
      this.backgroundColor = Colors.white,
      this.iconColor = kDarkBlue})
      : super(key: key);
  final icon, onPressed, backgroundColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(getAdaptiveWidth(8, context)),
        child: Container(
          height: getAdaptiveHeight(30, context),
          width: getAdaptiveHeight(30, context),
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black26,
              )
            ],
            borderRadius: BorderRadius.circular(getAdaptiveHeight(30, context)),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
