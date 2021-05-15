import 'package:flutter/material.dart';
import 'package:my_shop_app/ui/size_config.dart';

class RoundedNetworkImage extends StatelessWidget {
  const RoundedNetworkImage({
    Key key,
    @required this.size,
    this.image,
    this.onPressed,
    this.placeHolderIcon = Icons.add_a_photo_rounded,
  }) : super(key: key);

  final size, image, onPressed, placeHolderIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        color: Colors.black26,
        width: getAdaptiveHeight(size, context),
        height: getAdaptiveHeight(size, context),
        child: image == null || image == ''
            ? Center(
                child: Icon(
                  placeHolderIcon,
                  size: size / 2,
                  color: Colors.black87,
                ),
              )
            : Image.network(
                image,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
