import 'package:flutter/material.dart';
import 'package:my_shop_app/core/models/product.dart';
import 'package:my_shop_app/ui/widgets/product_preview_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    Key key,
    @required this.productList,
    @required this.listLength,
  }) : super(key: key);
  final productList, listLength;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: listLength,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final Product currentProduct = productList[index];
        return ProductPreviewCard(currentProduct: currentProduct);
      },
    );
  }
}
