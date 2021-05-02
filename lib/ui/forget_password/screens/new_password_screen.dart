import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
              Icons.security,
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
                  labelText: 'New password',
                  hintText: 'Enter your new password.',
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
                  labelText: 'Confirm password',
                  hintText: 'Confirm your password.',
                ),
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            OrangeButton(
              label: 'Update Password',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
