import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/data_access/data/user_data.dart' as data;
import 'package:my_shop_app/data_access/push_actions/actions.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:toast/toast.dart';

class ProfileNotifier extends ChangeNotifier {
  Gender get userGender => data.user.gender;

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
  }) {
    Account updatedUser = Account(
      name: name,
      mail: mail,
      password: password,
      imageUrl: imageUrl,
      address: address,
      phone: phone,
      gender: gender,
    );
    FocusManager.instance.primaryFocus.unfocus();
    updateUserData(updatedUser);
    notifyListeners();
    Navigator.pop(context);
    Toast.show(
      'Updated Successfully!',
      context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
    );
  }
}
