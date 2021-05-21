import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:toast/toast.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.close_rounded,
                size: getAppWidth(context) * 0.5,
                color: Colors.black26,
              ),
              Text(
                'No Internet Connection!',
                style: kSecondaryTextStyle(context).copyWith(
                    fontSize: getAdaptiveHeight(18, context),
                    color: Colors.black26),
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      final result =
                          await InternetAddress.lookup('www.google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        Navigator.pop(context);
                      }
                    } on SocketException catch (_) {
                      Toast.show('No internet connection yet.', context,
                          duration: Toast.LENGTH_LONG,
                          textColor: Colors.white,
                          backgroundColor: Colors.red.withOpacity(0.75));
                    }
                  },
                  child: Text(
                    'Try Again?',
                    style: kSecondaryTextStyle(context).copyWith(
                      fontSize: getAdaptiveHeight(18, context),
                      color: kDarkBlue,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
