import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:toast/toast.dart';

import '../../validators.dart';

User user = User(
    name: 'Omar Nabil',
    mail: 'omarmeciry21@gmail.com',
    imageUrl:
        'https://th.bing.com/th/id/R78c79313bcf397659cc7c517d81ebb90?rik=54AVAfZHVx1lJg&pid=ImgRaw',
    address: '12 Wabour ElNour st, Egypt',
    phone: '+205165402311',
    gender: Gender.Male);

class ProfileNotifier extends ChangeNotifier {
  Gender get userGender => user.gender;

  void toggleGender(Gender gender) {
    user.gender = gender;
    notifyListeners();
  }

  String get userName => user.name;
  String get userEmail => user.mail;
  String get userAddress => user.address;
  String get userPhone => user.phone;
  String get userImageUrl => user.imageUrl;

  void updateData({
    @required String name,
    @required String mail,
    @required String address,
    @required String phone,
    @required String imageUrl,
    @required Gender gender,
    @required BuildContext context,
  }) {
    User updatedUser = User(
      name: name,
      mail: mail,
      imageUrl: imageUrl,
      address: address,
      phone: phone,
      gender: gender,
    );
    FocusManager.instance.primaryFocus.unfocus();
    switch (checkValidity(updatedUser)) {
      case Validity.InvalidName:
        Toast.show(
          'Name can\'t be empty!',
          context,
          duration: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
        break;
      case Validity.InvalidEmail:
        Toast.show(
          'Invalid Email Format! Correct format: email@example.com',
          context,
          duration: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
        break;
      case Validity.InvalidPhone:
        Toast.show(
          'Invalid Phone Format! Correct format: an optional \'+\' sign with a 10-12 number & no characters',
          context,
          duration: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
        break;
      case Validity.Valid:
        updateUserData(updatedUser);
        notifyListeners();
        Navigator.pop(context);
        Toast.show(
          'Updated Successfully!',
          context,
          duration: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,
        );

        break;
      default:
    }
  }

  Validity checkValidity(User user) {
    if (!isNameValid(user.name)) return Validity.InvalidName;
    if (!isEmailValid(user.mail)) return Validity.InvalidEmail;
    if (!isPhoneValid(user.phone)) return Validity.InvalidPhone;
    return Validity.Valid;
  }

  bool isNameValid(String name) {
    return name.isNotEmpty;
  }

  bool isEmailValid(String email) => EmailSubmitRegexValidator().isValid(email);

  bool isPhoneValid(String phone) => PhoneNumberRegexValidator().isValid(phone);
}

updateUserData(User updatedUser) {
  user = updatedUser;
}
