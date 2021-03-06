import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/forget_password/notifiers/confirm_email_notifier.dart';
import 'package:my_shop_app/ui/routes.dart';
import 'package:provider/provider.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/register/notifiers/register_notifier.dart';
import 'package:my_shop_app/ui/login/notifiers/login_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyCartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConfirmEmailNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
