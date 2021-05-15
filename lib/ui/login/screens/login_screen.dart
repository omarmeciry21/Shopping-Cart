import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/data_access/push_actions/actions.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool progressShown = false;
  String emailError, passwordError;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ModalProgressHUD(
        inAsyncCall: progressShown,
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
                    controller: _emailController,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Email',
                      hintText: 'Enter your email.',
                      errorText: emailError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        emailError = emailValidityErrorText(value);
                      });
                    },
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
                    controller: _passwordController,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Password',
                      hintText: 'Enter your password.',
                      errorText: passwordError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        passwordError = passwordValidityErrorText(value);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                OrangeButton(
                  label: 'Login',
                  onPressed: () async {
                    FocusManager.instance.primaryFocus.unfocus();

                    if ((passwordError != null || emailError != null)) {
                    } else {
                      setState(() {
                        emailError = null;
                        passwordError = null;
                        progressShown = true;
                      });

                      try {
                        bool isSigned = await signInUser(
                            _emailController.text, _passwordController.text);
                        if (isSigned)
                          Toast.show('Signed in Successfully!', context,
                              duration: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              backgroundColor: Colors.green);
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        Toast.show(
                            'Account Not Found! Please, Register a new account first.',
                            context,
                            duration: Toast.LENGTH_LONG,
                            textColor: Colors.white,
                            backgroundColor: Colors.red);
                      }
                      setState(() {
                        progressShown = false;
                      });
                    }
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
      ),
    );
  }
}
