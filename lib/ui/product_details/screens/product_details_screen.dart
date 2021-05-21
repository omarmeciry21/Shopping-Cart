import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';

import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/blue_button.dart';
import 'package:my_shop_app/ui/widgets/outlined_icon_button.dart';
import 'package:provider/provider.dart';

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
          style: kScreenTitleTextStyle(context),
        ),
        leading: ElevatedRoundedIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Consumer<HomeNotifier>(
        builder: (_, favouritesNotifier, __) => SafeArea(
          child: Padding(
            padding: kScreenPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: getAdaptiveHeight(250, context),
                  alignment: Alignment.center,
                  child: Image.network(
                    '${product.imageUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: getAdaptiveHeight(15, context),
                ),
                Text(
                  '${product.title}',
                  style: kTitleTextStyle(context),
                ),
                SizedBox(
                  height: getAdaptiveHeight(5, context),
                ),
                Text(
                  '${product.description}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                Expanded(child: Container()),
                ProductDetailsActions(product, favouritesNotifier)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsActions extends StatefulWidget {
  final Product product;
  final HomeNotifier favouritesNotifier;

  const ProductDetailsActions(this.product, this.favouritesNotifier);

  @override
  _ProductDetailsActionsState createState() => _ProductDetailsActionsState();
}

class _ProductDetailsActionsState extends State<ProductDetailsActions> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MyCartNotifier>(
        builder: (_, cartNotifier, __) => Column(
          children: [
            Row(
              children: [
                OutlinedIconButton(
                  icon: Icons.add,
                  onPressed: () {
                    if (quantity >= 10)
                      return;
                    else
                      setState(() {
                        quantity++;
                      });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getAdaptiveWidth(15, context),
                  ),
                  child: Text(
                    '$quantity',
                    style: kQuantityTextStyle(context),
                  ),
                ),
                OutlinedIconButton(
                  icon: Icons.remove,
                  onPressed: () {
                    if (quantity <= 1)
                      return;
                    else
                      setState(() {
                        quantity--;
                      });
                  },
                ),
                Expanded(child: Container()),
                Text(
                  '${widget.product.moneySymbol}${widget.product.price * quantity}',
                  style: TextStyle(
                    color: kDarkBlue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getAdaptiveHeight(15, context),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    final bool currentState =
                        Provider.of<HomeNotifier>(context, listen: false)
                            .favouritesIdList
                            .contains(widget.product.productId);
                    if (currentState == true) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Unfavourite Product'),
                          content: Text(
                              'Are you sure you want to unfavourite this product?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'No',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<HomeNotifier>(context,
                                        listen: false)
                                    .toggleFavouriteButton(
                                        widget.product.productId);
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    } else
                      Provider.of<HomeNotifier>(context, listen: false)
                          .toggleFavouriteButton(widget.product.productId);
                  },
                  child: Container(
                    width: getAdaptiveHeight(35, context),
                    height: getAdaptiveHeight(35, context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: widget.product.isFavourite
                            ? kDarkBlue
                            : Colors.black45,
                      ),
                    ),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Provider.of<HomeNotifier>(context)
                              .favouritesIdList
                              .contains(widget.product.productId)
                          ? kDarkBlue
                          : Colors.black45,
                    ),
                  ),
                ),
                SizedBox(
                  width: getAdaptiveWidth(10, context),
                ),
                Expanded(
                  child: BlueButton(
                    text: 'Add to cart',
                    onPressed: () {
                      cartNotifier.addToCart(
                        widget.product,
                        quantity,
                        context,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: getAdaptiveWidth(10, context),
                ),
                Expanded(
                  child: BlueButton(
                    text: 'Buy Now',
                    onPressed: () {
                      cartNotifier.addToCart(
                        widget.product,
                        quantity,
                        context,
                      );
                      Navigator.pushReplacementNamed(context, '/home/my_cart');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
