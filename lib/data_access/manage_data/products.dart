import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';

List<Product> dataProducts;
List<Product> dataProductsFavourites;
List<Product> dataProductsFeatured;

Future<List<Product>> getProducts() async {
  List<Product> productsList = [];
  await FirebaseFirestore.instance.collection('products').get().then(
        (value) => value.docs.forEach(
          (element) {
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
  List<String> favouritesId = [];
  List<Product> favouritesList = [];

  await FirebaseFirestore.instance.collection('favourites').get().then(
      (value) => value.docs
              .where((element) =>
                  element['userId'] == FirebaseAuth.instance.currentUser.uid)
              .toList()
              .forEach((element) {
            favouritesId.add(element['productId']);
          }));

  favouritesList = (await getProducts()).where((element) {
    favouritesId.contains(element.productId)
        ? element.isFavourite = true
        : element.isFavourite = false;
    return favouritesId.contains(element.productId);
  }).toList();
  return favouritesList;
}

Future<void> toggleFavourite(String productId) async {
  if (dataProducts
          .where((element) => element.productId == productId)
          .toList()
          .first
          .isFavourite !=
      true) {
    await FirebaseFirestore.instance
        .collection('favourites')
        .doc('${FirebaseAuth.instance.currentUser.uid}-$productId')
        .set({
      'productId': productId,
      'userId': FirebaseAuth.instance.currentUser.uid
    });
    dataProductsFavourites.add(dataProducts
        .where((element) => element.productId == productId)
        .toList()
        .first);
  } else {
    await FirebaseFirestore.instance
        .collection('favourites')
        .doc('${FirebaseAuth.instance.currentUser.uid}-$productId')
        .delete();
    dataProductsFavourites.remove(dataProducts
        .where((element) => element.productId == productId)
        .toList()
        .first);
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
}
