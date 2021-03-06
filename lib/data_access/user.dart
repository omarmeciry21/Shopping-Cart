import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/cart.dart';
import 'package:my_shop_app/core/models/orders.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/cart.dart';
import 'package:my_shop_app/data_access/orders.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/no_internet/screens/no_internet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import './products.dart';

Account dataUser = Account(
    name: '',
    mail: '',
    password: '',
    imageUrl: '',
    address: '',
    phone: '',
    gender: Gender.Male);

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
    await user.user.sendEmailVerification();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Email Verification'),
        content: Text(
            'A verification email has been sent to your account. Please, verify your account and login.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Return to Login Screen'),
          ),
        ],
      ),
    );
    return true;
  } else
    return false;
}

Future<bool> signInUser(
    String email, String password, BuildContext context) async {
  UserCredential signedUser = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  if (!signedUser.user.emailVerified) {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Email Verification'),
        content: Text(
            'Your account hasn\'t been verified yet. Please, check your email.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Dismiss'),
          ),
        ],
      ),
    );
    return false;
  }
  if (dataUser != null) {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc('${signedUser.user.uid}')
        .get();
    Account userAccount = Account(
      name: userData.get('name').toString(),
      mail: userData.get('email').toString(),
      password: password,
      imageUrl: userData.get('imageUrl').toString(),
      address: userData.get('address').toString(),
      phone: userData.get('phone').toString(),
      gender: userData.get('gender').toString() == 'Male'
          ? Gender.Male
          : Gender.Female,
    );
    dataUser = userAccount;
    saveUserDataToSharedPrefs(userAccount);
    return true;
  } else {
    Toast.show(
        'Account Not Found! Please, Register a new account first.', context,
        duration: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red);
    return false;
  }
}

/*
String name, mail, imageUrl, address, phone, password;
  Gender gender;
   */
Future<void> saveUserDataToSharedPrefs(Account accountData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', accountData.name);
  prefs.setString('mail', accountData.mail);
  prefs.setString('imageUrl', accountData.imageUrl);
  prefs.setString('address', accountData.address);
  prefs.setString('phone', accountData.phone);
  prefs.setString('password', accountData.password);
  prefs.setString(
      'gender', accountData.gender == Gender.Male ? 'Male' : 'Female');
}

Future<Account> getUserDataFromSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('name') && prefs.getString('name') != '') {
    Account accountData = Account(
      name: prefs.getString('name'),
      mail: prefs.getString('mail'),
      password: prefs.getString('password'),
      imageUrl: prefs.getString('imageUrl'),
      address: prefs.getString('address'),
      phone: prefs.getString('phone'),
      gender: prefs.getString('gender') == 'Male' ? Gender.Male : Gender.Female,
    );
    return accountData;
  } else
    return null;
}

Future<bool> updateUserData(Account updatedUser) async {
  if (updatedUser != null) {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${FirebaseAuth.instance.currentUser.uid}')
          .set({
        'name': updatedUser.name,
        'email': updatedUser.mail,
        'password': dataUser.password,
        'address': updatedUser.address,
        'phone': updatedUser.phone,
        'gender': updatedUser.gender == Gender.Male ? 'Male' : 'Female',
        'imageUrl': updatedUser.imageUrl,
      });
      dataUser = updatedUser;
      saveUserDataToSharedPrefs(updatedUser);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  } else
    return false;
}

Future<void> updateImage(String url) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc('${FirebaseAuth.instance.currentUser.uid}')
      .set({
    'name': dataUser.name,
    'email': dataUser.mail,
    'password': dataUser.password,
    'address': dataUser.address,
    'phone': dataUser.phone,
    'gender': dataUser.gender == Gender.Male ? 'Male' : 'Female',
    'imageUrl': url,
  });
  dataUser.imageUrl = url;
  saveUserDataToSharedPrefs(dataUser);
}

Future<void> signUserOut() async {
  orders = Orders.clear(
      userId: FirebaseAuth.instance.currentUser.uid, ordersList: []);
  cart =
      Cart.clear(userId: FirebaseAuth.instance.currentUser.uid, cartItems: []);
  dataUser = Account.clear();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setString('name', '');
  dataProducts = [];
  dataProductsFavourites = [];
  dataProductsFeatured = [];

  favouritesId = [];

  await FirebaseAuth.instance.signOut();
}

Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Password Reset'),
      content: Text('An email has been sent to reset your password.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('Dismiss'),
        ),
      ],
    ),
  );
}

// ignore: missing_return
Future<bool> checkInternet(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoInternetScreen()));
    return false;
  }
}
