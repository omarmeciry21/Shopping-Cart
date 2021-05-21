import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/manage_data/categories.dart';

List<Product> dataProducts = [];
List<Product> dataProductsFavourites = [];
List<Product> dataProductsFeatured = [];

List<String> favouritesId = [];

Future<List<Product>> getProducts() async {
  List<Product> productsList = [];
  await FirebaseFirestore.instance.collection('products').get().then(
        (value) => value.docs.forEach(
          (element) async {
            if (categories == []) await fetchCategories();

            String valueString = element['color']
                .split('(0x')[1]
                .split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            Color productColor = new Color(value);

            productsList.add(
              Product(
                productId: element['productId'],
                title: element['title'],
                description: element['description'],
                imageUrl: element['imageUrl'],
                moneySymbol: element['moneySymbol'],
                categoryId: element['categoryId'],
                price: element['price'],
                color: productColor,
                isFeatured: element['isFeatured'],
              ),
            );
          },
        ),
      );
  return productsList;
}

Future<List<Product>> getFavourites() async {
  List<Product> favouritesList = [];
  List<String> favouritesIdList = [];

  await FirebaseFirestore.instance.collection('favourites').get().then(
        (value) => value.docs
            .where((element) =>
                element['userId'] == FirebaseAuth.instance.currentUser.uid)
            .toList()
            .forEach(
          (element) {
            favouritesIdList.add(
              element['productId'],
            );
          },
        ),
      );
  favouritesList = (await getProducts())
      .where((element) => favouritesIdList.contains(element.productId))
      .toList();

  for (int i = 0; i < favouritesList.length; i++) {
    favouritesList[i].isFavourite = true;
  }
  return favouritesList;
}

Future<void> toggleFavourite(String productId) async {
  if (!favouritesId.contains(productId)) {
    await FirebaseFirestore.instance
        .collection('favourites')
        .doc('${FirebaseAuth.instance.currentUser.uid}-$productId')
        .set({
      'productId': productId,
      'userId': FirebaseAuth.instance.currentUser.uid
    });
  } else {
    await FirebaseFirestore.instance
        .collection('favourites')
        .doc('${FirebaseAuth.instance.currentUser.uid}-$productId')
        .delete();
  }
}

Future<List<Product>> getFeatured() async {
  List<Product> featuredList = [];
  await FirebaseFirestore.instance.collection('products').get().then(
        (value) => value.docs
            .where((element) => element['isFeatured'] == true)
            .toList()
            .forEach(
          (element) {
            String valueString = element['color']
                .split('(0x')[1]
                .split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            Color productColor = new Color(value);
            featuredList.add(
              Product(
                productId: element['productId'],
                title: element['title'],
                description: element['description'],
                imageUrl: element['imageUrl'],
                moneySymbol: element['moneySymbol'],
                categoryId: element['categoryId'],
                price: element['price'],
                color: productColor,
                isFeatured: element['isFeatured'],
              ),
            );
          },
        ),
      );
  return featuredList;
}

Future<void> fetchProducts() async {
  dataProducts = await getProducts();
}

Future<void> fetchFeatured() async {
  dataProductsFeatured = await getFeatured();
}

Future<void> fetchFavourites() async {
  dataProductsFavourites = await getFavourites();
  favouritesId = [];
  dataProductsFavourites
      .forEach((element) => favouritesId.add(element.productId));
}
