import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/products_grid_view.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: ElevatedRoundedIconButton(
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Favourites',
          style: kScreenTitleTextStyle(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: kScreenPadding(context),
          child: Consumer<HomeNotifier>(
            builder: (_, homeNotifier, __) => ProductsGridView(
              listLength: homeNotifier.favourites.length,
              productList: homeNotifier.favourites,
            ),
          ),
        ),
      ),
    );
  }
}
