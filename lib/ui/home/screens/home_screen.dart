import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/drawer/home_page_drawer.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/home/widgets/categories_listview.dart';
import 'package:my_shop_app/ui/home/widgets/explore_product_card.dart';
import 'package:my_shop_app/ui/product_details/screens/product_details_screen.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/cart_numbered_icon.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchText = '';
  List<Product> filteredProducts = [];
  bool isSearching = false;
  void clearSearchingData() {
    _searchText = '';
    filteredProducts = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildAppBarTitle(context),
        leading: _buildAppBarLeading(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: kDarkBlue,
              size: getAdaptiveHeight(30, context),
            ),
            onPressed: () {
              setState(() {
                isSearching = true;
                clearSearchingData();
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                right: getAdaptiveWidth(5, context),
                top: getAdaptiveHeight(5, context)),
            child: CartNumberedIcon(
              onPressed: () => Navigator.pushNamed(context, '/home/my_cart'),
            ),
          ),
        ],
      ),
      drawer: HomePageDrawer(),
      body: Padding(
        padding: kScreenPadding(context),
        child: _buidHome(context),
      ),
    );
  }

  Widget _buildAppBarLeading() {
    return !isSearching
        ? ShowDrawerIcon()
        : ElevatedRoundedIconButton(
            icon: Icons.close,
            onPressed: () {
              setState(() {
                isSearching = false;
              });
            },
          );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    return !isSearching
        ? Text(
            'Explore',
            style: kScreenTitleTextStyle(context),
          )
        : _buildSearchTextField(context);
  }

  TextField _buildSearchTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: 'Search'),
      onChanged: (value) {
        if (value == "") {
          setState(() {
            clearSearchingData();
          });
        } else {
          setState(() {
            _searchText = value;
            filteredProducts = Provider.of<HomeNotifier>(context, listen: false)
                .products
                .where((element) => element.title
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
                .toList();
          });
        }
      },
    );
  }

  Widget _buildList() {
    if (_searchText == '')
      return Center(
          child: Text(
        'What are you looking for?',
        style: kSecondaryTextStyle(context).copyWith(),
      ));
    if (_searchText != '' && filteredProducts.isEmpty)
      return Center(
          child: Text(
        'Sorry! There is no available products with this name.\nYou can try something else.',
        textAlign: TextAlign.center,
        style: kSecondaryTextStyle(context).copyWith(),
      ));
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(
              filteredProducts[index].title,
              style: TextStyle(
                color: kDarkBlue,
                fontWeight: FontWeight.bold,
                fontSize: getAdaptiveHeight(16, context),
              ),
            ),
            trailing: Text(
                '${Provider.of<HomeNotifier>(context).categories.where((element) => element.categoryId == filteredProducts[index].categoryId).toList().first.title}'),
            onTap: () {
              FocusManager.instance.primaryFocus.unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(
                    filteredProducts[index],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _buidHome(BuildContext context) {
    return isSearching
        ? _buildList()
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Explore',
                  style: kTitleTextStyle(context),
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                Consumer<HomeNotifier>(
                  builder: (_, categoryNotifier, __) => Container(
                    width: double.infinity,
                    height: getAdaptiveHeight(130, context),
                    child: ListView.builder(
                      itemCount: categoryNotifier.featuredProducts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                  categoryNotifier.featuredProducts[index]),
                            ),
                          );
                        },
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
                Text(
                  'Categories',
                  style: kTitleTextStyle(context),
                ),
                SizedBox(
                  height: getAdaptiveHeight(20, context),
                ),
                SingleChildScrollView(child: CategoriesListView()),
              ],
            ),
          );
  }
}

class ShowDrawerIcon extends StatelessWidget {
  const ShowDrawerIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedRoundedIconButton(
      icon: Icons.menu,
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }
}





/*Expanded(
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
                    autofocus: false,
                    enabled: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
              ), */