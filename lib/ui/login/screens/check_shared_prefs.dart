import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/user.dart';
import 'package:my_shop_app/ui/login/notifiers/login_notifier.dart';
import 'package:provider/provider.dart';

class CheckSharedPrefsScreen extends StatefulWidget {
  @override
  _CheckSharedPrefsScreenState createState() => _CheckSharedPrefsScreenState();
}

class _CheckSharedPrefsScreenState extends State<CheckSharedPrefsScreen> {
  Account account;
  Future<void> checkSharedPrefs() async {
    account = await getUserDataFromSharedPrefs();
  }

  @override
  initState() {
    super.initState();
    checkSharedPrefs();
    if (account == Account.clear())
      Navigator.pushReplacementNamed(context, '/login');
    else {
      Provider.of<LoginNotifier>(context)
          .signInWithEmailAndPassword(account.mail, account.password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
