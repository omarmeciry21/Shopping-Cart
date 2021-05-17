import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';

List<Product> dataProducts = [];

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
                isFavourite: element['isFavourite'],
                isFeatured: element['isFeatured'],
              ),
            );
          },
        ),
      );
  return productsList;
}

Future<void> fetchProducts() async {
  dataProducts = await getProducts();
}
