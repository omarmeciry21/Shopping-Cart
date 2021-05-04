import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/size_config.dart';

const kDarkBlue = Color(0xFF163970);
const kDarkOrange = Color(0xFFEDBA1D);
const kTextFieldDecoration = InputDecoration(
  labelText: 'Value',
  hintText: 'Enter your Value',
  labelStyle: TextStyle(color: kDarkBlue),
  border: OutlineInputBorder(),
);
double kHalfScreenPadding(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.25;

TextStyle kTitleTextStyle(BuildContext context) => TextStyle(
      color: kDarkBlue,
      fontSize: getAdaptiveHeight(24, context),
      fontWeight: FontWeight.bold,
    );

EdgeInsets kScreenPadding(BuildContext context) => EdgeInsets.symmetric(
      horizontal: getAdaptiveWidth(20.0, context),
      vertical: getAdaptiveHeight(20.0, context),
    );
