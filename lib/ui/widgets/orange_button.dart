import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

class OrangeButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  const OrangeButton({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kHalfScreenPadding(context),
      ),
      child: Container(
        height: getAdaptiveHeight(40, context),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => kDarkOrange)),
          onPressed: onPressed,
          child: Text(
            '$label',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getAdaptiveHeight(16, context),
            ),
          ),
        ),
      ),
    );
  }
}
