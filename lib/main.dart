import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';

import 'package:my_shop_app/ui/product_details/notifiers/favourites_notifier.dart';
import 'package:my_shop_app/ui/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyCartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouritesNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
