import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/product_details/screens/product_details_screen.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:provider/provider.dart';

class ProductPreviewCard extends StatelessWidget {
  const ProductPreviewCard({
    Key key,
    @required this.currentProduct,
  }) : super(key: key);

  final Product currentProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(currentProduct),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getAdaptiveWidth(8, context),
            vertical: getAdaptiveHeight(8, context)),
        child: Stack(
          children: [
            Container(
              height: getAdaptiveHeight(150, context),
              width: getAdaptiveWidth(140, context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black12,
                      offset: Offset(5, 5),
                    )
                  ],
                  color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        currentProduct.imageUrl,
                        height: getAdaptiveHeight(90, context),
                        width: getAdaptiveWidth(90, context),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: getAdaptiveHeight(5, context),
                    ),
                    Text(
                      '${currentProduct.title}\n${currentProduct.moneySymbol}${currentProduct.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            ElevatedRoundedIconButton(
              onPressed: () => Provider.of<HomeNotifier>(context, listen: false)
                  .makeFavourite(currentProduct.productId, context),
              icon: Provider.of<HomeNotifier>(context)
                      .products
                      .where((element) => element == currentProduct)
                      .toList()
                      .first
                      .isFavourite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
