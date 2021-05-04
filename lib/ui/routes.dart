import 'package:my_shop_app/ui/forget_password/screens/confirm_email_screen.dart';
import 'package:my_shop_app/ui/forget_password/screens/new_password_screen.dart';
import 'package:my_shop_app/ui/forget_password/screens/verification_code_screen.dart';
import 'package:my_shop_app/ui/home/screens/home_screen.dart';
import 'package:my_shop_app/ui/login/screens/login_screen.dart';
import 'package:my_shop_app/ui/my_cart/screens/my_cart_screen.dart';
import 'package:my_shop_app/ui/register/screens/register_screen.dart';
import 'package:my_shop_app/ui/splash/screens/splash_screen.dart';

final routes = {
  '/': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/login/register': (context) => RegisterScreen(),
  '/login/forget': (context) => ConfirmEmailScreen(),
  '/login/forget/code': (context) => VerifyCodeScreen(),
  '/login/forget/new': (context) => NewPasswordScreen(),
  '/home': (context) => HomeScreen(),
  '/home/my_cart': (context) => MyCartScreen(),
};
