import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/home/widgets/explore_product_card.dart';
import 'package:my_shop_app/ui/home/widgets/category_tabbed_list.dart';
import 'package:my_shop_app/ui/product_details/screens/product_details_screen.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/cart_numbered_icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final cart_list = [''];
  final top_products = ['sda', 'dfs', 'dfs', 'dfs'];
  final int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (context) => CategoryTabsNotifier(),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: getAdaptiveWidth(10, context),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: getAdaptiveWidth(15, context),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(.3),
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25)),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ),
                    CartNumberedIcon(
                      list: cart_list,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                Text(
                  'Explore',
                  style: TextStyle(
                    color: kDarkBlue,
                    fontSize: getAdaptiveHeight(24, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                Consumer<CategoryTabsNotifier>(
                  builder: (_, categoryNotifier, __) => Container(
                    width: double.infinity,
                    height: getAdaptiveHeight(130, context),
                    child: ListView.builder(
                      itemCount: categoryNotifier.featuredProducts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                categoryNotifier.featuredProducts[index]),
                          ),
                        ),
                        child: ExploreProductCard(
                          color: categoryNotifier.featuredProducts[index].color,
                          image:
                              categoryNotifier.featuredProducts[index].imageUrl,
                          price: categoryNotifier.featuredProducts[index].price
                              .toString(),
                          title: categoryNotifier.featuredProducts[index].title,
                          priceSymbole: categoryNotifier
                              .featuredProducts[index].moneySymbol,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(20, context),
                ),
                CategoryTabbedList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}