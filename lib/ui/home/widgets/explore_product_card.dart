import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/size_config.dart';

// ignore: must_be_immutable
class ExploreProductCard extends StatelessWidget {
  final Color color;
  String image, price, title, priceSymbole;
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
      width: getAdaptiveWidth(130, context),
      height: getAdaptiveWidth(130, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: getAdaptiveHeight(70, context),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: getAdaptiveHeight(5, context),
            ),
            Flexible(
              child: Text(
                '${title.length > 12 ? title.substring(0, 12) + '...' : title}\n$priceSymbole$price',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
