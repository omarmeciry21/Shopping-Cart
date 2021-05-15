import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/push_actions/actions.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';
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

  String nameError, passwordError, emailError;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progressShown,
      child: Scaffold(
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
                      controller: _nameController,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Name',
                        hintText: 'Enter your full name.',
                        errorText: nameError,
                      ),
                      onChanged: (value) {
                        setState(() {
                          nameError = nameValidityErrorText(value);
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
                    height: getAdaptiveHeight(20, context),
                  ),
                  OrangeButton(
                    label: 'Register',
                    onPressed: () async {
                      FocusManager.instance.primaryFocus.unfocus();

                      if ((nameError != null ||
                          passwordError != null ||
                          emailError != null)) {
                      } else {
                        setState(() {
                          nameError = null;
                          emailError = null;
                          passwordError = null;
                          progressShown = true;
                        });
                        Account newUser = Account(
                          name: '${_nameController.text}',
                          mail: '${_emailController.text}',
                          password: '${_passwordController.text}',
                          imageUrl: null,
                          address: '',
                          phone: '',
                          gender: Gender.Male,
                        );
                        try {
                          await createNewUser(
                            newUser,
                            context,
                          );
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
    );
  }
}
