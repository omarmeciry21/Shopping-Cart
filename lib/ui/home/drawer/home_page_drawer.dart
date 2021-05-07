import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: getAdaptiveHeight(60, context),
                        height: getAdaptiveHeight(60, context),
                        child: Image.network(
                          'https://th.bing.com/th/id/R78c79313bcf397659cc7c517d81ebb90?rik=54AVAfZHVx1lJg&pid=ImgRaw',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getAdaptiveWidth(15, context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Omar Nabel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getAdaptiveHeight(24, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'omar@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getAdaptiveHeight(12, context),
                          ),
                        )
                      ],
                    ),
                  ],
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
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.favorite_rounded,
            text: 'Favourites',
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.track_changes_rounded,
            text: 'Orders',
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.list_rounded,
            text: 'Categories',
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.star_rate_rounded,
            text: 'Featured Products',
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.rate_review_rounded,
            text: 'Ratings',
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.contact_support,
            text: 'Contact us',
            color: Colors.black45,
            onPressed: () {},
          ),
          DrawerCustomizedTile(
            icon: Icons.info,
            text: 'About us',
            color: Colors.black45,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerCustomizedTile extends StatelessWidget {
  const DrawerCustomizedTile({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
    this.color = kDarkBlue,
  }) : super(key: key);

  final icon, text, color, onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      trailing: color == Colors.black45
          ? Container(
              width: 0,
              height: 0,
            )
          : Icon(
              Icons.arrow_forward_ios_rounded,
              size: getAdaptiveHeight(20, context),
              color: Colors.black45,
            ),
      leading: Icon(
        icon,
        size: getAdaptiveHeight(25, context),
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: getAdaptiveHeight(14, context),
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {},
    );
  }
}
