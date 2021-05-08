import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';

class User {
  final String name, mail, imageUrl, address, phone;
  Gender gender;

  User({
    @required this.name,
    @required this.mail,
    @required this.imageUrl,
    @required this.address,
    @required this.phone,
    @required this.gender,
  });
}
