import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
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
              Icons.lock,
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
                  labelText: 'Verification Code',
                  hintText: 'Enter the code sent to your email.',
                ),
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            OrangeButton(
              label: 'Verify',
              onPressed: () {
                Navigator.pushNamed(context, '/login/forget/new');
              },
            ),
          ],
        ),
      ),
    );
  }
}
