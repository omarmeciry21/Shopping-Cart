import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/category.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/products_grid_view.dart';
import 'package:provider/provider.dart';

class ViewCategoryScreen extends StatelessWidget {
  final Category category;

  const ViewCategoryScreen({Key key, @required this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productOfCategoryList = Provider.of<HomeNotifier>(context)
        .products
        .where((element) => element.categoryId == category.categoryId)
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ElevatedRoundedIconButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${category.title}',
          style: kScreenTitleTextStyle(context),
        ),
      ),
      body: Padding(
        padding: kScreenPadding(context),
        child: SafeArea(
          child: ProductsGridView(
            listLength: productOfCategoryList.length,
            productList: productOfCategoryList,
          ),
        ),
      ),
    );
  }
}
