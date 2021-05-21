import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/size_config.dart';

// ignore: must_be_immutable
class OutlinedIconButton extends StatelessWidget {
  OutlinedIconButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.containerDimensions = 25,
    this.iconSize = 15,
    this.color,
  }) : super(key: key);

  final IconData icon;
  final Function onPressed;
  final double containerDimensions, iconSize;
  dynamic color;

  @override
  Widget build(BuildContext context) {
    if (color == null) color = Colors.black45;
    return GestureDetector(
      onTap: onPressed == null ? () {} : onPressed,
      child: Container(
        height: getAdaptiveHeight(containerDimensions, context),
        width: getAdaptiveHeight(containerDimensions, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(iconSize),
          border: Border.all(
            width: 1,
            color: color,
          ),
          color: color == Colors.black45 ? Colors.white : color,
        ),
        child: Icon(
          icon,
          size: iconSize.toDouble(),
          color: color == Colors.black45 ? color : Colors.white,
        ),
      ),
    );
  }
}
