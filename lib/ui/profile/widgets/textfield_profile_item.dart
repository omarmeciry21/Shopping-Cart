import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/profile/widgets/profile_single_item_row.dart';
import 'package:my_shop_app/ui/size_config.dart';

class TextFieldProfileItem extends StatelessWidget {
  const TextFieldProfileItem({
    Key key,
    @required this.controller,
    @required this.hint,
    @required this.label,
    this.fontSize = 18,
    this.maxLength = 40,
    this.trailingIcon,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
    this.isDisabled = false,
  });

  final TextEditingController controller;
  final hint, label;
  final fontSize, maxLength;
  final trailingIcon;
  final obscureText, errorText, onChanged, isDisabled;

  @override
  Widget build(BuildContext context) {
    return ProfileSingleItemRow(
      firstChild: Padding(
        padding: EdgeInsets.only(
          top: getAdaptiveHeight(5.0, context),
        ),
        child: Text(
          '$label',
          style: kSecondaryTextStyle(context),
        ),
      ),
      secondChild: TextField(
        enabled: !isDisabled,
        controller: controller,
        obscureText: obscureText,
        maxLength: maxLength,
        onChanged: onChanged,
        style: TextStyle(
          color: kDarkBlue,
          fontWeight: FontWeight.bold,
          fontSize: getAdaptiveHeight(fontSize, context),
        ),
        decoration: InputDecoration(
            hintText: '$hint',
            contentPadding: EdgeInsets.zero,
            errorText: errorText, ),
      ),
      trailingIcon: trailingIcon == null ? Container() : trailingIcon,
    );
  }
}
