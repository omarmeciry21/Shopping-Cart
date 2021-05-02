import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/size_config.dart';

class ExploreProductCard extends StatelessWidget {
  final Color color;
  final String image, price, title, priceSymbole;
  ExploreProductCard({
    Key key,
    @required this.color,
    @required this.image,
    @required this.price,
    @required this.title,
    this.priceSymbole = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getAdaptiveWidth(8, context),
          vertical: getAdaptiveHeight(4, context)),
      width: getAdaptiveWidth(100, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: getAdaptiveHeight(70, context),
                width: getAdaptiveWidth(70, context),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(5, context),
            ),
            Text(
              '$title\n$priceSymbole$price',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
