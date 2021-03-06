import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/size_config.dart';

enum Gender { Male, Female }
enum Validity { InvalidEmail, InvalidName, InvalidPhone, Valid }
enum OrderState { Delivered, Submitted, InProgress, Canceled, Failed }

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

EdgeInsets kScreenPadding(BuildContext context) => EdgeInsets.symmetric(
      horizontal: getAdaptiveWidth(20.0, context),
      vertical: getAdaptiveHeight(5.0, context),
    );
TextStyle kTitleTextStyle(BuildContext context) => TextStyle(
      color: kDarkBlue,
      fontSize: getAdaptiveHeight(24, context),
      fontWeight: FontWeight.bold,
    );

TextStyle kScreenTitleTextStyle(BuildContext context) {
  return TextStyle(
    color: kDarkBlue,
    fontWeight: FontWeight.bold,
    fontSize: getAdaptiveHeight(20, context),
  );
}

TextStyle kSecondaryTextStyle(BuildContext context) {
  return kQuantityTextStyle(context).copyWith(
    fontSize: getAdaptiveHeight(18, context),
    color: Colors.black38,
  );
}

TextStyle kQuantityTextStyle(context) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: getAdaptiveHeight(20, context),
    color: Colors.black45,
  );
}

TextStyle kSingleLineTextStyle(context) =>
    TextStyle(color: Colors.black87, fontSize: getAdaptiveHeight(14, context));

BoxDecoration kContainerBoxDecoration(BuildContext context) => BoxDecoration(
      borderRadius: BorderRadius.circular(getAdaptiveHeight(20, context)),
      color: Colors.black12.withOpacity(0.05),
    );
