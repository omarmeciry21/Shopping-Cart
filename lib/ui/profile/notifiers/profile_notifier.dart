import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/manage_data/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:toast/toast.dart';

class ProfileNotifier extends ChangeNotifier {
  Gender get userGender => dataUser.gender;
  String get imageUrl => dataUser.imageUrl;
  String get userName => dataUser.name;
  String get userMail => dataUser.mail;

  void uploadImage(String url) {
    dataUser.imageUrl = url;
    updateImage(url);
    notifyListeners();
  }

  void deleteProfilePhoto() async {
    await updateImage('');
    notifyListeners();
  }

  void toggleGender(Gender gender) {
    dataUser.gender = gender;
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

      await updateUserData(updatedUser);
      notifyListeners();
      Navigator.pop(context);
      Toast.show(
        'Updated Successfully!',
        context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.green.withOpacity(0.75),
      );
    } catch (e) {
      Toast.show(
        '$e',
        context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.red.withOpacity(0.75),
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

  int imageProgress;
  void updateImageProgress(int completed, int total) {
    double progress = completed / total * 100;
    imageProgress = progress.toInt();
    notifyListeners();
  }
}
