import 'package:flutter/material.dart';
import 'package:my_shop_app/data_access/contact_us.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/blue_button.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:toast/toast.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedRoundedIconButton(
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: kScreenPadding(context),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(getAdaptiveHeight(60, context)),
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    height: getAdaptiveHeight(120.0, context),
                  ),
                ),
                Text(
                  'Contact Us',
                  style: kTitleTextStyle(context).copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: getAdaptiveHeight(28, context),
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                TextField(
                  controller: _messageController,
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Your Message'),
                  maxLines: 6,
                  maxLength: 250,
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kHalfScreenPadding(context),
                    vertical: getAdaptiveHeight(5, context),
                  ),
                  child: BlueButton(
                      text: 'Send',
                      onPressed: () async {
                        bool messageState = await contactUsMessage(
                          message: _messageController.text,
                        );
                        if (messageState == true) {
                          _messageController.clear();
                          Navigator.pop(context);
                          Toast.show(
                            'Sent Successfully!',
                            context,
                            duration: Toast.LENGTH_LONG,
                            backgroundColor: Colors.green.withOpacity(0.75),
                            textColor: Colors.white,
                          );
                        } else {
                          FocusManager.instance.primaryFocus.unfocus();
                          Toast.show(
                            'An error occured! Please, try again.',
                            context,
                            duration: Toast.LENGTH_LONG,
                            backgroundColor: Colors.red.withOpacity(0.75),
                            textColor: Colors.white,
                          );
                        }
                      }),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
