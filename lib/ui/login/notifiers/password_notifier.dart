import 'package:flutter/widgets.dart';
import 'package:my_shop_app/ui/validators.dart';

class LoginNotifier extends ChangeNotifier {
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String passwordError, emailError;
  void onEmailChanged(String email) {
    emailError = emailValidityErrorText(email);
    notifyListeners();
  }

  void onPasswordChanged(String password) {
    passwordError = passwordValidityErrorText(password);
    notifyListeners();
  }

  void resetErrors() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }
}
