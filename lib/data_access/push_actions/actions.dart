import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/data/user_data.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/validators.dart';
import '../data/user_data.dart' as data;

bool contactUsMessage({@required String message, @required String userEmail}) {
  print('$message submitted by $userEmail');
  return true;
}

Future<bool> createNewUser(Account newUser, BuildContext context) async {
  UserCredential user = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: newUser.mail, password: newUser.password);
  if (user != null) {
    FirebaseFirestore.instance.collection('users').doc('${user.user.uid}').set({
      'name': newUser.name,
      'email': newUser.mail,
      'password': newUser.password,
      'address': newUser.address,
      'phone': newUser.phone,
      'gender': newUser.gender == Gender.Male ? 'Male' : 'Female',
      'imageUrl': newUser.imageUrl,
    });
    data.user = newUser;
    return true;
  } else
    return false;
}

Future<bool> signInUser(String email, String password) async {
  UserCredential signedUser = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  if (data.user != null) {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc('${signedUser.user.uid}')
        .get();
    data.user = Account(
      name: userData.get('name').toString(),
      mail: userData.get('email').toString(),
      password: userData.get('password').toString(),
      imageUrl: userData.get('imageUrl').toString(),
      address: userData.get('address').toString(),
      phone: userData.get('phone').toString(),
      gender: userData.get('gender').toString() == 'Male'
          ? Gender.Male
          : Gender.Female,
    );
    return true;
  } else
    return false;
}

updateUserData(Account updatedUser) {
  data.user = updatedUser;
}
