import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';

class AboutUsScreen extends StatelessWidget {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: kDarkBlue.withOpacity(0.75),
                radius: getAdaptiveHeight(70, context),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getAdaptiveHeight(60, context),
                      ),
                      border: Border.all(
                          color: kDarkOrange.withOpacity(0.85), width: 3)),
                  height: getAdaptiveHeight(120, context),
                  width: getAdaptiveHeight(120, context),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/profile_pic.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getAdaptiveHeight(15, context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getAdaptiveHeight(40, context),
                  vertical: getAdaptiveHeight(5, context),
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/facebook.png',
                    height: getAdaptiveHeight(40, context),
                    width: getAdaptiveHeight(40, context),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'omar.nabel.54',
                    style: kScreenTitleTextStyle(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getAdaptiveHeight(40, context),
                  vertical: getAdaptiveHeight(5, context),
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/linkedin.png',
                    height: getAdaptiveHeight(40, context),
                    width: getAdaptiveHeight(40, context),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'Omar Nabil ElMesiry',
                    style: kScreenTitleTextStyle(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getAdaptiveHeight(40, context),
                  vertical: getAdaptiveHeight(5, context),
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/whatsapp.png',
                    height: getAdaptiveHeight(40, context),
                    width: getAdaptiveHeight(40, context),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    '+201220445875',
                    style: kScreenTitleTextStyle(context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getAdaptiveHeight(40, context),
                  vertical: getAdaptiveHeight(5, context),
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/gmail.jpg',
                    height: getAdaptiveHeight(40, context),
                    width: getAdaptiveHeight(40, context),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'omarmeciry21@gmail.com',
                    style:
                        kScreenTitleTextStyle(context).copyWith(fontSize: 16),
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
