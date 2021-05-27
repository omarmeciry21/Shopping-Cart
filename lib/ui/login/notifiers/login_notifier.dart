import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/data_access/cart.dart';
import 'package:my_shop_app/data_access/categories.dart';
import 'package:my_shop_app/data_access/products.dart';
import 'package:my_shop_app/data_access/user.dart';
import 'package:my_shop_app/ui/home/screens/home_screen.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

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

  signInWithEmailAndPassword(
      String email, String password, bool showToast, context) async {
    try {
      bool isSigned = await signInUser(email, password, context);
      if (isSigned) {
        try {
          await fetchProducts();
          await fetchFavourites();
          await fetchFeatured();
          await fetchCategories();
          await fetchCartItems();
        } catch (e) {
          print(e);
        }

        resetErrors();

        if (showToast)
          Toast.show('Signed in Successfully!', context,
              duration: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.green.withOpacity(0.75));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      print(e);
      if (showToast)
        Toast.show('Incorrect email or password! Please, try again.', context,
            duration: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red.withOpacity(0.75));
    }
  }
}
