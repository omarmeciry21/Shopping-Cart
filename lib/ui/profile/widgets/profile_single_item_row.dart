import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/size_config.dart';

// ignore: must_be_immutable
class ProfileSingleItemRow extends StatelessWidget {
  ProfileSingleItemRow({
    Key key,
    @required this.firstChild,
    @required this.secondChild,
    this.trailingIcon,
    this.height,
  }) : super(key: key);
  final firstChild, secondChild, height;
  Widget trailingIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? getAppHegiht(context) / 7 : height,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getAdaptiveHeight(10, context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: firstChild,
            ),
            Expanded(
              flex: 4,
              child: secondChild,
            ),
            trailingIcon == null ? Container() : trailingIcon,
          ],
        ),
      ),
    );
  }
}
