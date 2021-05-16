import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/data/user_data.dart';
import 'package:my_shop_app/ui/constants.dart';
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

Future<bool> updateUserData(Account updatedUser) async {
  if (updatedUser != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser.uid}')
        .set({
      'name': updatedUser.name,
      'email': updatedUser.mail,
      'password': updatedUser.password,
      'address': updatedUser.address,
      'phone': updatedUser.phone,
      'gender': updatedUser.gender == Gender.Male ? 'Male' : 'Female',
      'imageUrl': updatedUser.imageUrl,
    });
    data.user = updatedUser;
    return true;
  } else
    return false;
}

Future<void> deleteUserImage() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc('${FirebaseAuth.instance.currentUser.uid}')
      .set({
    'name': data.user.name,
    'email': data.user.mail,
    'password': data.user.password,
    'address': data.user.address,
    'phone': data.user.phone,
    'gender': data.user.gender == Gender.Male ? 'Male' : 'Female',
    'imageUrl': '',
  });
  data.user.imageUrl = '';
}

Future<void> signUserOut() async {
  await FirebaseAuth.instance.signOut();
  data.user = Account.clear();
}
