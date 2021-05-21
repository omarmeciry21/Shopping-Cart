import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> contactUsMessage({@required String message}) async {
  try {
    await FirebaseFirestore.instance.collection('contact_us').add({
      'userId': FirebaseAuth.instance.currentUser.uid,
      'message': message,
    });
  } catch (e) {
    print(e);
  }
  return true;
}
