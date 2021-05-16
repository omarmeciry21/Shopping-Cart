import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/data/user_data.dart' as data;
import 'package:my_shop_app/data_access/push_actions/actions.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:toast/toast.dart';

class ProfileNotifier extends ChangeNotifier {
  Gender get userGender => data.user.gender;
  String get imageUrl => data.user.imageUrl;

  void toggleGender(Gender gender) {
    data.user.gender = gender;
    notifyListeners();
  }

  void updateData({
    @required String name,
    @required String mail,
    @required String address,
    @required String phone,
    @required String imageUrl,
    @required String password,
    @required Gender gender,
    @required BuildContext context,
  }) async {
    try {
      Account updatedUser = Account(
        name: name == null ? '' : name,
        mail: mail == null ? '' : mail,
        password: password == null ? '' : password,
        imageUrl: imageUrl == null ? '' : imageUrl,
        address: address == null ? '' : address,
        phone: phone == null ? '' : phone,
        gender: gender == null ? '' : gender,
      );
      FocusManager.instance.primaryFocus.unfocus();

      await updateUserData(updatedUser);
      notifyListeners();
      Navigator.pop(context);
      Toast.show(
        'Updated Successfully!',
        context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Toast.show(
        '$e',
        context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    }
  }

  String nameError, phoneError;
  void onNameChanged(value) {
    nameError = nameValidityErrorText(value);
    notifyListeners();
  }

  void onPhoneChanged(value) {
    phoneError = phoneValidityErrorText(value);
    notifyListeners();
  }

  void resetErrors() {
    nameError = null;
    phoneError = null;
    notifyListeners();
  }

  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
