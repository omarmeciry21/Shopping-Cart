import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

class DrawerCustomizedTile extends StatelessWidget {
  const DrawerCustomizedTile({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
    this.color = kDarkBlue,
  }) : super(key: key);

  final icon, text, color, onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      trailing: color == Colors.black45
          ? Container(
              width: 0,
              height: 0,
            )
          : Icon(
              Icons.arrow_forward_ios_rounded,
              size: getAdaptiveHeight(20, context),
              color: Colors.black45,
            ),
      leading: Icon(
        icon,
        size: getAdaptiveHeight(25, context),
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: getAdaptiveHeight(14, context),
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onPressed,
    );
  }
}
