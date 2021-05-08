import 'package:flutter/widgets.dart';
import 'package:my_shop_app/core/models/user.dart';
import 'package:my_shop_app/ui/constants.dart';

class ProfileNotifier extends ChangeNotifier {
  User user = User(
      name: 'Omar Nabil',
      mail: 'omarmeciry21@gmail.com',
      imageUrl:
          'https://th.bing.com/th/id/R78c79313bcf397659cc7c517d81ebb90?rik=54AVAfZHVx1lJg&pid=ImgRaw',
      address: '12 Wabour ElNour st, Egypt',
      phone: '+205165402311',
      gender: Gender.Male);
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
  }) {
    user = User(
      name: name,
      mail: mail,
      imageUrl: imageUrl,
      address: address,
      phone: phone,
      gender: gender,
    );
    notifyListeners();
  }
}
