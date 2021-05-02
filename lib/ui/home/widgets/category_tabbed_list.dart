import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:provider/provider.dart';

class CategoryTabbedList extends StatelessWidget {
  CategoryTabbedList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categoryNames = [];
    Provider.of<CategoryTabsNotifier>(context)
        .categories
        .forEach((e) => categoryNames.add(e.title));
    return SingleChildScrollView(
      child: Consumer<CategoryTabsNotifier>(
        builder: (_, cateogryNotifier, __) => Column(
          children: [
            TextTabsList(
              items: categoryNames,
              selectedIndex: cateogryNotifier.selectedIndex,
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: cateogryNotifier.selectedCategoryProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final Product currentProduct =
                      cateogryNotifier.selectedCategoryProducts[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getAdaptiveWidth(8, context),
                        vertical: getAdaptiveHeight(8, context)),
                    child: Container(
                      height: getAdaptiveHeight(150, context),
                      width: getAdaptiveWidth(140, context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black12,
                              offset: Offset(5, 5),
                            )
                          ],
                          color: Colors.white),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                currentProduct.imageUrl,
                                height: getAdaptiveHeight(90, context),
                                width: getAdaptiveWidth(90, context),
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: getAdaptiveHeight(5, context),
                            ),
                            Text(
                              '${currentProduct.title}\n${currentProduct.moneySymbol}${currentProduct.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
                  onTap: () => Provider.of<CategoryTabsNotifier>(
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
