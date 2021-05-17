import 'package:flutter/material.dart';
import 'package:my_shop_app/data_access/manage_data/user.dart';

bool contactUsMessage({@required String message}) {
  print('$message submitted by ${dataUser.mail}');
  return true;
}
