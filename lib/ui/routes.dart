import 'package:my_shop_app/ui/about_us/screens/about_us_screen.dart';
import 'package:my_shop_app/ui/contact_us/screens/contact_us_screen.dart';
import 'package:my_shop_app/ui/favourites/screens/favourites_screen.dart';
import 'package:my_shop_app/ui/featured/screens/featured_products_screen.dart';
import 'package:my_shop_app/ui/forget_password/screens/confirm_email_screen.dart';
import 'package:my_shop_app/ui/home/screens/home_screen.dart';
import 'package:my_shop_app/ui/login/screens/login_screen.dart';
import 'package:my_shop_app/ui/my_cart/screens/my_cart_screen.dart';
import 'package:my_shop_app/ui/my_orders/screens/my_orders_screen.dart';
import 'package:my_shop_app/ui/profile/screens/profile_screen.dart';
import 'package:my_shop_app/ui/register/screens/register_screen.dart';
import 'package:my_shop_app/ui/splash/screens/splash_screen.dart';

final routes = {
  '/': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/login/register': (context) => RegisterScreen(),
  '/login/forget': (context) => ConfirmEmailScreen(),
  '/home': (context) => HomeScreen(),
  '/home/my_cart': (context) => MyCartScreen(),
  '/home/profile': (context) => ProfileScreen(),
  '/home/favourites': (context) => FavouritesScreen(),
  '/home/my_orders': (context) => MyOrdersScreen(),
  '/home/featured_products': (context) => FeaturedProductsScreen(),
  '/home/contact_us': (context) => ContactUsScreen(),
  '/home/about_us': (context) => AboutUsScreen(),
};
