// 601.92 * 313
import 'package:flutter/cupertino.dart';

double getAppHegiht(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

double getAppWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getAdaptiveWidth(num width, BuildContext context) {
  //return width / 313.92 * MediaQuery.of(context).size.width;
  return width.toDouble();
}

double getAdaptiveHeight(num height, BuildContext context) {
  //return height / 601.92 * MediaQuery.of(context).size.height;
  return height.toDouble();
}
