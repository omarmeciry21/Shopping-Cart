import 'package:flutter/material.dart';
import 'package:my_shop_app/data_access/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/forget_password/notifiers/confirm_email_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/orange_button.dart';
import 'package:provider/provider.dart';

class ConfirmEmailScreen extends StatefulWidget {
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
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
              Icons.email,
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
                controller: _emailController,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Email',
                  hintText: 'Enter your email.',
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
                controller: _confirmEmailController,
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Confirm email',
                    hintText: 'Confirm your email.',
                    errorText: Provider.of<ConfirmEmailNotifier>(context)
                        .confirmError),
                onChanged: (value) {
                  Provider.of<ConfirmEmailNotifier>(context, listen: false)
                      .onConfirmChanged(value, _emailController.text);
                },
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            OrangeButton(
              label: 'Next',
              onPressed: () {
                if (Provider.of<ConfirmEmailNotifier>(context, listen: false)
                            .confirmError ==
                        null &&
                    _confirmEmailController.text.isNotEmpty)
                  sendPasswordResetEmail(_confirmEmailController.text, context);
              },
            )
          ],
        ),
      ),
    );
  }
}
