import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/product_preview_card.dart';
import 'package:my_shop_app/ui/widgets/products_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryTabbedList extends StatelessWidget {
  CategoryTabbedList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categoryNames = [];
    Provider.of<HomeNotifier>(context)
        .categories
        .forEach((e) => categoryNames.add(e.title));
    return SingleChildScrollView(
      child: Consumer<HomeNotifier>(
        builder: (_, homeNotifier, __) => Column(
          children: [
            TextTabsList(
              items: categoryNames,
              selectedIndex: homeNotifier.selectedIndex,
            ),
            ProductsGridView(
              listLength: homeNotifier.selectedCategoryProducts.length,
              productList: homeNotifier.selectedCategoryProducts,
            ),
          ],
        ),
      ),
    );
  }
}

class TextTabsList extends StatelessWidget {
  TextTabsList({
    Key key,
    @required this.items,
    @required this.selectedIndex,
  }) : super(key: key);

  final List<String> items;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getAdaptiveHeight(30, context),
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            right: getAdaptiveWidth(30, context),
          ),
          child: index == selectedIndex
              ? Column(
                  children: [
                    Text(
                      '${items[index]}',
                      style: TextStyle(
                        color: kDarkBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(3, context),
                    ),
                    Container(
                        height: getAdaptiveHeight(2, context),
                        width: getAdaptiveWidth(
                            items[index].length.toDouble() * 5, context),
                        color: kDarkBlue)
                  ],
                )
              : GestureDetector(
                  onTap: () => Provider.of<HomeNotifier>(
                    context,
                    listen: false,
                  ).updateIndex(index),
                  child: Text(
                    '${items[index]}',
                    style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
