import 'package:flutter/material.dart';

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
