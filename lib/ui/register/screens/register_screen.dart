import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                ),
                Container(
                  child: Icon(
                    Icons.account_circle,
                    color: kDarkBlue,
                    size: getAdaptiveHeight(100, context),
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
                      labelText: 'Name',
                      hintText: 'Enter your full name.',
                    ),
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(10, context),
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
                  height: getAdaptiveHeight(10, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getAdaptiveWidth(10.0, context),
                  ),
                  child: TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Password',
                      hintText: 'Enter your password.',
                    ),
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(10, context),
                ),
                SizedBox(
                  height: getAdaptiveHeight(10, context),
                ),
                OrangeButton(
                  label: 'Register',
                  onPressed: () {},
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Sign in.',
                        style: TextStyle(
                          color: kDarkOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
