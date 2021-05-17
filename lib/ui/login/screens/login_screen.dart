import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/data_access/manage_data/products.dart';
import 'package:my_shop_app/data_access/manage_data/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/login/notifiers/password_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool progressShown = false;

  @override
  void dispose() {
    super.dispose();
    Provider.of<LoginNotifier>(context, listen: false).resetErrors();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ModalProgressHUD(
        inAsyncCall: progressShown,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<LoginNotifier>(
            builder: (context, loginNotifier, __) => SafeArea(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(getAdaptiveHeight(60, context)),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        height: getAdaptiveHeight(120.0, context),
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
                          errorText: loginNotifier.emailError,
                        ),
                        onChanged: (value) {
                          loginNotifier.onEmailChanged(value);
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
                        obscureText: !loginNotifier.isPasswordVisible,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Password',
                          hintText: 'Enter your password.',
                          errorText: loginNotifier.passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginNotifier.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kDarkBlue.withOpacity(0.75),
                            ),
                            onPressed: () {
                              loginNotifier.togglePasswordVisibility();
                            },
                          ),
                        ),
                        onChanged: (value) {
                          loginNotifier.onPasswordChanged(value);
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

                        if ((loginNotifier.passwordError != null ||
                            loginNotifier.emailError != null)) {
                        } else {
                          setState(() {
                            loginNotifier.resetErrors();
                            progressShown = true;
                          });

                          try {
                            bool isSigned = await signInUser(
                                _emailController.text,
                                _passwordController.text);
                            if (isSigned) {
                              await fetchProducts();
                              await fetchFavourites();
                              await fetchFeatured();

                              Toast.show('Signed in Successfully!', context,
                                  duration: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.green);
                              Navigator.pushReplacementNamed(context, '/home');
                            }
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
                        onTap: () =>
                            Navigator.pushNamed(context, '/login/forget'),
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
        ),
      ),
    );
  }
}
