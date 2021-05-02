// 601.92 * 313.92

import 'package:flutter/cupertino.dart';

double getAdaptiveWidth(double width, BuildContext context) {
  return width / 313.92 * MediaQuery.of(context).size.width;
}

double getAdaptiveHeight(double height, BuildContext context) {
  return height / 601.92 * MediaQuery.of(context).size.height;
}
