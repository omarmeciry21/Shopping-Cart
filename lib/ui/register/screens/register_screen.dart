import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/manage_data/products.dart';
import 'package:my_shop_app/data_access/manage_data/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/register/notifiers/register_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool progressShown = false;

  @override
  void dispose() {
    super.dispose();
    Provider.of<RegisterNotifier>(context, listen: false).resetErrors();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progressShown,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Consumer<RegisterNotifier>(
                builder: (_, registerNotifier, __) => Column(
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
                        controller: _nameController,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Name',
                          hintText: 'Enter your full name.',
                          errorText: registerNotifier.nameError,
                        ),
                        onChanged: (value) {
                          registerNotifier.onNameChanged(value);
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
                        controller: _emailController,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Email',
                          hintText: 'Enter your email.',
                          errorText: registerNotifier.emailError,
                        ),
                        onChanged: (value) {
                          setState(() {
                            registerNotifier.onEmailChanged(value);
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
                        obscureText: !registerNotifier.isPasswordVisible,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Password',
                          hintText: 'Enter your password.',
                          errorText: registerNotifier.passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              registerNotifier.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kDarkBlue.withOpacity(0.75),
                            ),
                            onPressed: () {
                              registerNotifier.togglePasswordVisibility();
                            },
                          ),
                        ),
                        onChanged: (value) {
                          registerNotifier.onPasswordChanged(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(20, context),
                    ),
                    OrangeButton(
                      label: 'Register',
                      onPressed: () async {
                        FocusManager.instance.primaryFocus.unfocus();

                        if ((registerNotifier.nameError != null ||
                            registerNotifier.passwordError != null ||
                            registerNotifier.emailError != null)) {
                        } else {
                          setState(() {
                            registerNotifier.resetErrors();
                            progressShown = true;
                          });
                          Account newUser = Account(
                            name: '${_nameController.text}',
                            mail: '${_emailController.text}',
                            password: '${_passwordController.text}',
                            imageUrl: '',
                            address: '',
                            phone: '',
                            gender: Gender.Male,
                          );
                          try {
                            await createNewUser(
                              newUser,
                              context,
                            );
                            await fetchProducts();
                            await fetchFavourites();
                            await fetchFeatured();
                            Toast.show('Created Successfully!', context,
                                duration: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                backgroundColor: Colors.green);
                            Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            Toast.show('Email already exists!', context,
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
        ),
      ),
    );
  }
}
