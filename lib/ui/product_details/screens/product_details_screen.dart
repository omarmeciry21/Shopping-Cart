import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Product Details',
          style: TextStyle(
            color: kDarkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              product.isFavourite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: kDarkBlue,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
