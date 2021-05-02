import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/login/screens/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      home: LoginScreen(),
      duration: 4000,
      imageSize: 250,
      imageSrc: "assets/images/logo.jpg",
      text: "Shopping Cart",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 40.0,
        color: kDarkBlue,
        fontWeight: FontWeight.w900,
      ),
      backgroundColor: Colors.white,
    );
  }
}
