import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/data_access/data/cart.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/product_details/notifiers/favourites_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen(this.product);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouritesNotifier(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Product Details',
            style: TextStyle(
              color: kDarkBlue,
              fontWeight: FontWeight.bold,
              fontSize: getAdaptiveHeight(20, context),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.all(getAdaptiveWidth(8, context)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black26,
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: kDarkBlue,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Consumer<FavouritesNotifier>(
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
      ),
    );
  }
}

class ProductDetailsActions extends StatefulWidget {
  final Product product;
  final favouritesNotifier;

  const ProductDetailsActions(this.product, this.favouritesNotifier);

  @override
  _ProductDetailsActionsState createState() => _ProductDetailsActionsState();
}

class _ProductDetailsActionsState extends State<ProductDetailsActions> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyCartNotifier(),
      child: Column(
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black45,
                  ),
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
          Consumer<MyCartNotifier>(
            builder: (_, cartNotifier, __) => Row(
              children: [
                GestureDetector(
                  onTap: () => widget.favouritesNotifier
                      .makeFavourite(widget.product.productId),
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
                      color: widget.product.isFavourite
                          ? kDarkBlue
                          : Colors.black45,
                    ),
                  ),
                ),
                SizedBox(
                  width: getAdaptiveWidth(10, context),
                ),
                BlueButton(
                  text: 'Add to cart',
                  onPressed: () {
                    cartNotifier.addToCart(widget.product.productId, quantity);
                    print(cartNotifier.cartItems);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: getAdaptiveWidth(10, context),
                ),
                BlueButton(
                  text: 'Buy Now',
                  onPressed: () {
                    cartNotifier.addToCart(widget.product.productId, quantity);
                    Navigator.pushNamed(context, '/home/my_cart');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: getAdaptiveHeight(45, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kDarkBlue,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlinedIconButton extends StatelessWidget {
  const OutlinedIconButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getAdaptiveHeight(25, context),
        width: getAdaptiveHeight(25, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black45),
        ),
        child: Icon(
          icon,
          size: 15,
          color: Colors.black45,
        ),
      ),
    );
  }
}
