import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(getAdaptiveHeight(60, context)),
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    height: getAdaptiveHeight(120.0, context),
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
                height: getAdaptiveHeight(15, context),
              ),
              OrangeButton(
                label: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              SizedBox(
                height: getAdaptiveHeight(15, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black87),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/login/register'),
                    child: Text(
                      'Register Now',
                      style: TextStyle(
                        color: kDarkOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getAdaptiveHeight(35, context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getAdaptiveWidth(10.0, context),
                ),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login/forget'),
                  child: Text(
                    'Forgot your password? ',
                    style: TextStyle(color: kDarkBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
