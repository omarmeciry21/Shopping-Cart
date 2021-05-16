import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';

class Account {
  String name, mail, imageUrl, address, phone, password;
  Gender gender;

  Account({
    @required this.name,
    @required this.mail,
    @required this.password,
    @required this.imageUrl,
    @required this.address,
    @required this.phone,
    @required this.gender,
  });
  Account.clear();
}
