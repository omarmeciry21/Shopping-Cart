import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/profile/widgets/gender_group_icons.dart';
import 'package:my_shop_app/ui/profile/widgets/profile_single_item_row.dart';
import 'package:my_shop_app/ui/profile/widgets/textfield_profile_item.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/rounded_network_image.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  ProfileNotifier profileNotifier;
  String _imageUrl;
  Gender _gender;
  void fetchAccountData() {
    profileNotifier = Provider.of<ProfileNotifier>(context);
    _nameController.text = profileNotifier.userName;
    _emailController.text = profileNotifier.userEmail;
    _addressController.text = profileNotifier.userAddress;
    _phoneController.text = profileNotifier.userPhone;
    _imageUrl = profileNotifier.userImageUrl;
    _gender = profileNotifier.userGender;
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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          ElevatedRoundedIconButton(
            icon: Icons.check_rounded,
            backgroundColor: Colors.green,
            iconColor: Colors.white,
            onPressed: () {
              profileNotifier.updateData(
                name: _nameController.text,
                mail: _emailController.text,
                address: _addressController.text,
                phone: _phoneController.text,
                imageUrl: _imageUrl,
                gender: _gender,
              );
              Navigator.pop(context);
              Toast.show(
                'Updated Successfully!',
                context,
                duration: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
              );
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
                nameController: _nameController,
                hint: 'Enter your full name...',
                label: 'Name',
              ),
              TextFieldProfileItem(
                nameController: _emailController,
                hint: 'Enter your email...',
                label: 'Email',
                fontSize: 14,
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
                nameController: _phoneController,
                hint: 'Enter your phome number...',
                label: 'Phone',
                maxLength: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
