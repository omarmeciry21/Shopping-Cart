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
  @override
  initState() {
    super.initState();
    checkSharedPrefs();
  }

  Future<void> checkSharedPrefs() async {
    Account account = await getUserDataFromSharedPrefs();
    if (account != null) {
      await Provider.of<LoginNotifier>(context, listen: false)
          .signInWithEmailAndPassword(
              account.mail, account.password, false, context);
    } else
      Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
