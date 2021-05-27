import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/data_access/cart.dart';
import 'package:my_shop_app/data_access/categories.dart';
import 'package:my_shop_app/data_access/products.dart';
import 'package:my_shop_app/data_access/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/screens/home_screen.dart';
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
  void initState() {
    super.initState();
    checkInternet(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          progressShown = false;
        });
        return false;
      },
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
                      ),
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(15, context),
                    ),
                    OrangeButton(
                      label: 'Login',
                      onPressed: () async {
                        FocusManager.instance.primaryFocus.unfocus();

                        loginNotifier
                            .onPasswordChanged(_passwordController.text);
                        loginNotifier.onEmailChanged(_emailController.text);

                        if ((loginNotifier.passwordError != null ||
                            loginNotifier.emailError != null)) {
                        } else if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          Toast.show(
                              'Please, fill up the empty fields.', context,
                              duration: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              backgroundColor: Colors.red.withOpacity(0.75));
                        } else {
                          if ((await checkInternet(context)) == true) {
                            setState(() {
                              loginNotifier.resetErrors();
                              progressShown = true;
                            });

                            try {
                              bool isSigned = await signInUser(
                                  _emailController.text,
                                  _passwordController.text,
                                  context);
                              if (isSigned) {
                                await fetchProducts();
                                await fetchFavourites();
                                await fetchFeatured();
                                await fetchCategories();
                                try {
                                  await fetchCartItems();
                                } catch (e) {}

                                Provider.of<LoginNotifier>(context,
                                        listen: false)
                                    .resetErrors();

                                Toast.show('Signed in Successfully!', context,
                                    duration: Toast.LENGTH_LONG,
                                    textColor: Colors.white,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.75));
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            } catch (e) {
                              Toast.show(
                                  'Incorrect email or password! Please, try again.',
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor:
                                      Colors.red.withOpacity(0.75));
                            }

                            setState(() {
                              progressShown = false;
                            });
                          }
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
                          onTap: () async {
                            if ((await checkInternet(context)) == true)
                              Navigator.pushNamed(context, '/login/register');
                          },
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
                        onTap: () async {
                          if ((await checkInternet(context)) == true)
                            Navigator.pushNamed(context, '/login/forget');
                        },
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
