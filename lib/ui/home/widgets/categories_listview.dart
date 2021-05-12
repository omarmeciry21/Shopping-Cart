import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_shop_app/core/models/category.dart';
import 'package:my_shop_app/ui/view_category/screens/view_category_screen.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/home/notifiers/home_notifier.dart';
import 'package:my_shop_app/ui/size_config.dart';
import 'package:provider/provider.dart';

class CategoriesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: Provider.of<HomeNotifier>(context).categories.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewCategoryScreen(
                    category:
                        Provider.of<HomeNotifier>(context).categories[index]))),
        child: SizedBox(
          child: CategoryListItem(
              category: Provider.of<HomeNotifier>(context).categories[index]),
        ),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.category,
    this.height = 60,
  }) : super(key: key);

  final Category category;
  final height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getAdaptiveHeight(height, context),
          width: double.infinity,
          decoration: BoxDecoration(
            color: category.color,
            borderRadius: BorderRadius.circular(
              getAdaptiveHeight(15, context),
            ),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getAdaptiveHeight(5, context),
          ),
          child: Opacity(
            opacity: 0.25,
            child: Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: getAdaptiveHeight(height, context),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getAdaptiveHeight(15, context),
            ),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getAdaptiveHeight(5, context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: getAdaptiveWidth(20, context)),
                child: Text(
                  '${category.title}',
                  style: kTitleTextStyle(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getAdaptiveHeight(30, context)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
