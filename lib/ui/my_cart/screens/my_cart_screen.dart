import 'package:flutter/material.dart';
import 'package:my_shop_app/data_access/user.dart';
import 'package:my_shop_app/ui/constants.dart';
import 'package:my_shop_app/ui/my_cart/notifiers/cart_notifier.dart';
import 'package:my_shop_app/ui/my_cart/widgets/cart_item_list_widget.dart';
import 'package:my_shop_app/ui/submit_order/screens/submit_order_screen.dart';
import 'package:my_shop_app/ui/widgets/elevated_rounded_icon_button.dart';
import 'package:my_shop_app/ui/widgets/blue_button.dart';
import 'package:provider/provider.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedRoundedIconButton(
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cart Page',
          style: kScreenTitleTextStyle(context),
        ),
      ),
      body: Padding(
        padding: kScreenPadding(context),
        child: SafeArea(
          child: Consumer<MyCartNotifier>(
            builder: (_, cartNotifier, __) => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartNotifier.cartLength,
                    itemBuilder: (context, index) {
                      return CartItemListWidget(
                        cartNotifier: cartNotifier,
                        index: index,
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Total:',
                      style: kTitleTextStyle(context)
                          .copyWith(color: Colors.black87),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${cartNotifier.totalPrice}',
                      style: kTitleTextStyle(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                BlueButton(
                  text: 'Checkout',
                  onPressed: () {
                    if (dataUser.address == '' ||
                        dataUser.phone == '' ||
                        dataUser.address.isEmpty ||
                        dataUser.phone.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Uncomplete Profile'),
                          content: Text(
                              'In order to place an order, you have to provide your phone number and address. Please, complete your profile and try again.'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Dismiss')),
                            TextButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, '/home/profile'),
                                child: Text('Go to My Profile'))
                          ],
                        ),
                      );
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitOrderScreen(
                            cartItems: cartNotifier.items,
                          ),
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
