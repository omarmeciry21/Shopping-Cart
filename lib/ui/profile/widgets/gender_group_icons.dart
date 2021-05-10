import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/outlined_icon_button.dart';
import 'package:provider/provider.dart';

class GenderGroupIcons extends StatelessWidget {
  const GenderGroupIcons({
    Key key,
    @required this.gender,
  }) : super(key: key);
  final Gender gender;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (_, genderNotifer, __) => Row(
        children: [
          OutlinedIconButton(
            containerDimensions: 40,
            iconSize: 25,
            color: genderNotifer.userGender == Gender.Male ? kDarkBlue : null,
            icon: FontAwesomeIcons.mars,
            onPressed: () {
              genderNotifer.toggleGender(Gender.Male);
            },
          ),
          SizedBox(
            width: getAdaptiveWidth(15, context),
          ),
          OutlinedIconButton(
            containerDimensions: 40,
            iconSize: 25,
            color: genderNotifer.userGender == Gender.Female ? kDarkBlue : null,
            icon: FontAwesomeIcons.venus,
            onPressed: () {
              genderNotifer.toggleGender(Gender.Female);
            },
          ),
        ],
      ),
    );
  }
}