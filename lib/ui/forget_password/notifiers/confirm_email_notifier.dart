import 'package:flutter/widgets.dart';

class ConfirmEmailNotifier extends ChangeNotifier {
  String confirmError;

  onConfirmChanged(String confirmText, String emailText) {
    if (confirmText != emailText)
      confirmError = 'Email is not the same as entered above.';
    else
      confirmError = null;
    notifyListeners();
  }
}
