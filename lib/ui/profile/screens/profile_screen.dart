import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_shop_app/data_access/data/user_data.dart';
import 'package:my_shop_app/data_access/push_actions/actions.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/profile/widgets/gender_group_icons.dart';
import 'package:my_shop_app/ui/profile/widgets/profile_single_item_row.dart';
import 'package:my_shop_app/ui/profile/widgets/textfield_profile_item.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/validators.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/rounded_network_image.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String _imageUrl;
  Gender _gender;
  void fetchAccountData() {
    _nameController.text = user.name;
    _emailController.text = user.mail;
    _addressController.text = user.address;
    _passController.text = user.password;
    _phoneController.text = user.phone;
    _imageUrl = user.imageUrl;
    _gender = user.gender;
  }

  @override
  Widget build(BuildContext context) {
    fetchAccountData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ElevatedRoundedIconButton(
          onPressed: () {
            Provider.of<ProfileNotifier>(context, listen: false).resetErrors();
            Navigator.pop(context);
          },
        ),
        actions: [
          Consumer<ProfileNotifier>(
            builder: (_, profileNotifier, __) => ElevatedRoundedIconButton(
              icon: Icons.check_rounded,
              backgroundColor: Colors.green,
              iconColor: Colors.white,
              onPressed: () {
                FocusManager.instance.primaryFocus.unfocus();

                if ((profileNotifier.nameError != null ||
                    profileNotifier.phoneError != null)) {
                } else {
                  profileNotifier
                    ..resetErrors()
                    ..updateData(
                      name: _nameController.text,
                      mail: _emailController.text,
                      password: _passController.text,
                      address: _addressController.text,
                      phone: _phoneController.text,
                      imageUrl: _imageUrl,
                      gender: _gender,
                      context: context,
                    );

                  Provider.of<ProfileNotifier>(context, listen: false)
                      .resetErrors();
                  Navigator.pop(context);
                }
              },
            ),
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
              ImageSection(),
              Consumer<ProfileNotifier>(
                builder: (_, profileNotifier, __) => NameSection(
                  nameController: _nameController,
                  errorText: profileNotifier.nameError,
                  onChanged: (value) {
                    profileNotifier.onNameChanged(value);
                  },
                ),
              ),
              EmailSection(
                emailController: _emailController,
              ),
              PasswordSection(
                passController: _passController,
              ),
              AddressSection(
                addressController: _addressController,
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
              Consumer<ProfileNotifier>(
                builder: (_, profileNotifier, __) => TextFieldProfileItem(
                  controller: _phoneController,
                  hint: 'Phone number',
                  label: 'Phone',
                  maxLength: 13,
                  errorText: profileNotifier.phoneError,
                  onChanged: (value) {
                    profileNotifier.onPhoneChanged(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordSection extends StatelessWidget {
  final TextEditingController passController;

  const PasswordSection({Key key, @required this.passController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (_, profileNotifier, __) => TextFieldProfileItem(
        controller: passController,
        hint: 'Enter your password',
        label: 'Password',
        fontSize: 14,
        isDisabled: true,
        obscureText: !profileNotifier.isPasswordVisible,
        trailingIcon: IconButton(
          icon: Icon(
            profileNotifier.isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: kDarkBlue.withOpacity(0.75),
          ),
          onPressed: () {
            profileNotifier.togglePasswordVisibility();
          },
        ),
      ),
    );
  }
}

class AddressSection extends StatelessWidget {
  const AddressSection({
    Key key,
    @required TextEditingController addressController,
  })  : _addressController = addressController,
        super(key: key);

  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return ProfileSingleItemRow(
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
    );
  }
}

class NameSection extends StatelessWidget {
  const NameSection({
    Key key,
    @required TextEditingController nameController,
    this.errorText,
    this.onChanged,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;
  final errorText, onChanged;
  @override
  Widget build(BuildContext context) {
    return ProfileSingleItemRow(
      firstChild: Text(
        'Name',
        style: kQuantityTextStyle(context).copyWith(
          fontSize: getAdaptiveHeight(18, context),
          color: Colors.black38,
        ),
      ),
      secondChild: TextField(
        controller: _nameController,
        style: TextStyle(
          color: kDarkBlue,
          fontWeight: FontWeight.bold,
          fontSize: getAdaptiveHeight(14, context),
        ),
        decoration: InputDecoration(
          hintText: 'Full Name',
          contentPadding: EdgeInsets.zero,
          errorText: errorText,
        ),
        maxLength: 150,
        maxLines: 5,
        onChanged: onChanged,
      ),
    );
  }
}

class EmailSection extends StatelessWidget {
  EmailSection({
    @required TextEditingController emailController,
    this.errorText,
    this.onChanged,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final errorText, onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFieldProfileItem(
      controller: _emailController,
      hint: 'email@example.com',
      label: 'Email',
      fontSize: 14,
      errorText: errorText,
      onChanged: onChanged,
      isDisabled: true,
    );
  }
}

class ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileSingleItemRow(
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
              image:
                  Provider.of<ProfileNotifier>(context, listen: false).imageUrl,
            ),
          ),
          SizedBox(
            height: getAdaptiveHeight(15, context),
          ),
          Row(
            children: [
              Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: getAdaptiveHeight(16, context),
                  color: kDarkBlue.withOpacity(0.7),
                ),
              ),
              SizedBox(
                width: getAdaptiveWidth(8, context),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Delete Profile Image'),
                            content: Text(
                                'Are you sure you want to delete this image?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  try {
                                    deleteUserImage();
                                    Toast.show(
                                      'Image Deleted Successfully!',
                                      context,
                                      textColor: Colors.white.withOpacity(0.75),
                                      backgroundColor:
                                          Colors.green.withOpacity(0.75),
                                    );
                                    Navigator.pop(context);
                                  } catch (e) {}
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ));
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: getAdaptiveHeight(16, context),
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
