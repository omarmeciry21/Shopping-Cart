import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

class ElevatedRoundedIconButton extends StatelessWidget {
  const ElevatedRoundedIconButton({
    Key key,
    this.icon = Icons.arrow_back,
    @required this.onPressed,
  }) : super(key: key);
  final icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(getAdaptiveWidth(8, context)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black26,
              )
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            color: kDarkBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
