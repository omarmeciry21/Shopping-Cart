import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/category.dart';

List<Category> categories = [];

Future<List<Category>> getCategories() async {
  List<Category> categoryData = [];
  await FirebaseFirestore.instance.collection('categories').get().then(
        (value) => value.docs.forEach(
          (element) {
            String valueString = element['color']
                .split('(0x')[1]
                .split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            Color categoryColor = new Color(value);

            categoryData.add(
              Category(
                categoryId: element['categoryId'],
                title: element['title'],
                color: categoryColor,
                imageUrl: element['imageUrl'],
              ),
            );
          },
        ),
      );
  return categoryData;
}

Future<void> fetchCategories() async {
  categories = await getCategories();
}
