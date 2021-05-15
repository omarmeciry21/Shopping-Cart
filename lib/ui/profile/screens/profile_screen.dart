import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/data_access/data/user_data.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/profile/widgets/gender_group_icons.dart';
import 'package:my_shop_app/ui/profile/widgets/profile_single_item_row.dart';
import 'package:my_shop_app/ui/profile/widgets/textfield_profile_item.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/rounded_network_image.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  ProfileNotifier profileNotifier;
  String _imageUrl;
  Gender _gender;
  bool isPasswordVisible = false;
  String nameError, emailError, passError, phoneError;
  bool progressShown = false;
  void fetchAccountData() {
    print(user.name);
    _nameController.text = user.name;
    _emailController.text = user.mail;
    _addressController.text = user.address;
    _passController.text = user.password;
    _phoneController.text = user.phone;
    _imageUrl = user.imageUrl;
    _gender = user.gender;

    _nameController.addListener(() {
      setState(() {
        nameError = nameValidityErrorText(_nameController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_nameController.text.isEmpty) fetchAccountData();
    return ModalProgressHUD(
      inAsyncCall: progressShown,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: ElevatedRoundedIconButton(
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            ElevatedRoundedIconButton(
              icon: Icons.check_rounded,
              backgroundColor: Colors.green,
              iconColor: Colors.white,
              onPressed: () {
                FocusManager.instance.primaryFocus.unfocus();

                if ((nameError != null ||
                    passError != null ||
                    emailError != null)) {
                } else {
                  setState(() {
                    nameError = null;
                    emailError = null;
                    passError = null;
                    progressShown = true;
                  });
                  profileNotifier.updateData(
                    name: _nameController.text,
                    mail: _emailController.text,
                    password: _passController.text,
                    address: _addressController.text,
                    phone: _phoneController.text,
                    imageUrl: _imageUrl,
                    gender: _gender,
                    context: context,
                  );
                  setState(() {
                    progressShown = false;
                  });
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: kScreenPadding(context)
                .copyWith(left: getAdaptiveWidth(30, context)),
            child: ListView(
              children: [
                ProfileSingleItemRow(
                  firstChild: Text(
                    'Profile',
                    style: kTitleTextStyle(context).copyWith(
                      fontSize: getAdaptiveHeight(34, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  secondChild: Container(),
                ),
                ProfileSingleItemRow(
                  height: getAppHegiht(context) * 1.75 / 7,
                  firstChild: Text(
                    'Photo',
                    style: kQuantityTextStyle(context).copyWith(
                      fontSize: getAdaptiveHeight(18, context),
                      color: Colors.black38,
                    ),
                  ),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: RoundedNetworkImage(
                          size: getAdaptiveHeight(70, context),
                          image: _imageUrl,
                        ),
                      ),
                      SizedBox(
                        height: getAdaptiveHeight(15, context),
                      ),
                      Text(
                        'Upload Image',
                        style: TextStyle(
                          fontSize: getAdaptiveHeight(16, context),
                          color: kDarkBlue.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFieldProfileItem(
                  controller: _nameController,
                  hint: 'Full Name',
                  label: 'Name',
                  fontSize: 18,
                ),
                TextFieldProfileItem(
                    controller: _emailController,
                    hint: 'email@example.com',
                    label: 'Email',
                    fontSize: 14,
                    errorText: emailError),
                TextFieldProfileItem(
                  controller: _passController,
                  hint: 'Enter your password',
                  label: 'Password',
                  fontSize: 14,
                  errorText: passError,
                  obscureText: !isPasswordVisible,
                  trailingIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kDarkBlue,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                ProfileSingleItemRow(
                  firstChild: Text(
                    'Address',
                    style: kQuantityTextStyle(context).copyWith(
                      fontSize: getAdaptiveHeight(18, context),
                      color: Colors.black38,
                    ),
                  ),
                  secondChild: TextField(
                    controller: _addressController,
                    style: TextStyle(
                      color: kDarkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: getAdaptiveHeight(14, context),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Please, enter a specific address...',
                      contentPadding: EdgeInsets.zero,
                    ),
                    maxLength: 150,
                    maxLines: 5,
                  ),
                ),
                ProfileSingleItemRow(
                  firstChild: Text(
                    'Gender',
                    style: kSecondaryTextStyle(context),
                  ),
                  secondChild: GenderGroupIcons(
                    gender: _gender,
                  ),
                ),
                TextFieldProfileItem(
                  controller: _phoneController,
                  hint: 'Phone number',
                  label: 'Phone',
                  maxLength: 13,
                  errorText: phoneError,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
