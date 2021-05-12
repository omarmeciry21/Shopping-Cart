import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/data/products.dart';
import 'package:my_shop_app/ui/featured/screens/featured_products_screen.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _searchText = '';
  List<Product> filteredProducts;

  _SearchScreenState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredProducts =
              Provider.of<HomeNotifier>(context).featuredProducts;
        });
      } else {
        setState(() {
          _searchText = _searchController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:
            ElevatedRoundedIconButton(onPressed: () => Navigator.pop(context)),
        title: TextField(
          controller: _searchController,
        ),
      ),
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List<Product> tempList = [];
      for (int i = 0; i < filteredProducts.length; i++) {
        if (filteredProducts[i]
            .title
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredProducts[i]);
        }
      }
      filteredProducts = tempList;
    }
    return ListView.builder(
      itemCount: Provider.of<HomeNotifier>(context).featuredProducts == null
          ? 0
          : filteredProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredProducts[index].title),
          onTap: () => print(filteredProducts[index].title),
        );
      },
    );
  }
}
