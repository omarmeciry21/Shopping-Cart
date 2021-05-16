import 'package:flutter/widgets.dart';
import 'package:my_shop_app/ui/validators.dart';

class RegisterNotifier extends ChangeNotifier {
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String nameError, passwordError, emailError;
  void onNameChanged(String name) {
    nameError = nameValidityErrorText(name);
    notifyListeners();
  }

  void onEmailChanged(String email) {
    emailError = emailValidityErrorText(email);
    notifyListeners();
  }

  void onPasswordChanged(String password) {
    passwordError = passwordValidityErrorText(password);
    notifyListeners();
  }

  void resetErrors() {
    nameError = null;
    emailError = null;
    passwordError = null;
    notifyListeners();
  }
}
