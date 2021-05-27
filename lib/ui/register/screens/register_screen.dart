import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/user.dart';
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
                      ),
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(20, context),
                    ),
                    OrangeButton(
                      label: 'Register',
                      onPressed: () async {
                        FocusManager.instance.primaryFocus.unfocus();

                        registerNotifier.onNameChanged(_nameController.text);
                        registerNotifier
                            .onPasswordChanged(_passwordController.text);
                        registerNotifier.onEmailChanged(_emailController.text);

                        if ((registerNotifier.nameError != null ||
                            registerNotifier.passwordError != null ||
                            registerNotifier.emailError != null)) {
                        } else if (_emailController.text.isEmpty ||
                            _nameController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          Toast.show(
                              'Please, fill up the empty fields.', context,
                              duration: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              backgroundColor: Colors.red.withOpacity(0.75));
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
                            Provider.of<RegisterNotifier>(context,
                                    listen: false)
                                .resetErrors();
                          } catch (e) {
                            Toast.show('Email already exists!', context,
                                duration: Toast.LENGTH_LONG,
                                textColor: Colors.white,
                                backgroundColor: Colors.red.withOpacity(0.75));
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
