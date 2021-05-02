import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';

class ConfirmEmailScreen extends StatefulWidget {
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.email,
              size: getAdaptiveHeight(100, context),
              color: kDarkBlue,
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getAdaptiveWidth(10.0, context),
              ),
              child: TextField(
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Email',
                  hintText: 'Enter your email.',
                ),
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getAdaptiveWidth(10.0, context),
              ),
              child: TextField(
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Confirm email',
                  hintText: 'Confirm your email.',
                ),
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            OrangeButton(
              label: 'Next',
              onPressed: () {
                Navigator.pushNamed(context, '/login/forget/code');
              },
            )
          ],
        ),
      ),
    );
  }
}
