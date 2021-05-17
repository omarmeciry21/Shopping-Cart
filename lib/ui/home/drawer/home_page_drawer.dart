import 'package:flutter/material.dart';
import 'package:my_shop_app/data_access/manage_data/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/widgets/drawer_customized_tile.dart';
import 'package:my_shop_app/ui/profile/notifiers/profile_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/rounded_network_image.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/home/profile'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedNetworkImage(
                        size: 60,
                        image: Provider.of<ProfileNotifier>(context).imageUrl,
                      ),
                      SizedBox(
                        width: getAdaptiveWidth(15, context),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${Provider.of<ProfileNotifier>(context).userName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getAdaptiveHeight(24, context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${Provider.of<ProfileNotifier>(context).userMail}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getAdaptiveHeight(12, context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(10, context),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: kDarkOrange,
            ),
          ),
          DrawerCustomizedTile(
            icon: Icons.person_rounded,
            text: 'Profile',
            onPressed: () => Navigator.pushNamed(context, '/home/profile'),
          ),
          DrawerCustomizedTile(
            icon: Icons.favorite_rounded,
            text: 'Favourites',
            onPressed: () => Navigator.pushNamed(context, '/home/favourites'),
          ),
          DrawerCustomizedTile(
            icon: Icons.track_changes_rounded,
            text: 'Orders',
            onPressed: () => Navigator.pushNamed(context, '/home/my_orders'),
          ),
          DrawerCustomizedTile(
            icon: Icons.star_rate_rounded,
            text: 'Featured Products',
            onPressed: () =>
                Navigator.pushNamed(context, '/home/featured_products'),
          ),
          DrawerCustomizedTile(
            icon: Icons.contact_support,
            text: 'Contact us',
            color: Colors.black45,
            onPressed: () => Navigator.pushNamed(context, '/home/contact_us'),
          ),
          DrawerCustomizedTile(
            icon: Icons.info,
            text: 'About us',
            color: Colors.black45,
            onPressed: () => Navigator.pushNamed(context, '/home/about_us'),
          ),
          DrawerCustomizedTile(
            icon: Icons.exit_to_app_rounded,
            text: 'Sign out',
            color: Colors.black45,
            onPressed: () {
              signUserOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
