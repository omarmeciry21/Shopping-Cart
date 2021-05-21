import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_shop_app/core/models/cart.dart';
import 'package:my_shop_app/core/models/cart_item.dart';

Cart cart = Cart(userId: FirebaseAuth.instance.currentUser.uid, cartItems: []);

Future<List<CartItem>> getCartItems() async {
  List<CartItem> cartItems = [];
  await FirebaseFirestore.instance
      .collection('carts')
      .doc('${FirebaseAuth.instance.currentUser.uid}')
      .get()
      .then((value) {
    value['items'].forEach(
      (item) => cartItems.add(
        CartItem(
          itemId: item['itemId'],
          productId: item['productId'],
          quantity: item['quantity'],
          unitPrice: item['unitPrice'],
          price: item['price'],
        ),
      ),
    );
  });
  return cartItems;
}

Future<bool> addToCart(CartItem item) async {
  try {
    cart.cartItems.add(item);
    List<Map<String, dynamic>> cartItemsAsMap = [];
    cart.cartItems.forEach(
      (element) => cartItemsAsMap.add(
        {
          'itemId': element.itemId,
          'price': element.price,
          'productId': element.productId,
          'quantity': element.quantity,
          'unitPrice': element.unitPrice,
        },
      ),
    );
    await FirebaseFirestore.instance
        .collection('carts')
        .doc('${FirebaseAuth.instance.currentUser.uid}')
        .set(
      {
        'userId': FirebaseAuth.instance.currentUser.uid,
        'items': cartItemsAsMap,
      },
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> removeFromCart(CartItem item) async {
  try {
    cart.cartItems.remove(item);
    List<Map<String, dynamic>> cartItemsAsMap = [];
    cart.cartItems.forEach(
      (element) => cartItemsAsMap.add(
        {
          'itemId': element.itemId,
          'price': element.price,
          'productId': element.productId,
          'quantity': element.quantity,
          'unitPrice': element.unitPrice,
        },
      ),
    );
    await FirebaseFirestore.instance
        .collection('carts')
        .doc('${FirebaseAuth.instance.currentUser.uid}')
        .set({
      'userId': FirebaseAuth.instance.currentUser.uid,
      'items': cartItemsAsMap,
    });
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> fetchCartItems() async {
  cart.cartItems = await getCartItems();
}

Future<bool> updateCartItem(CartItem oldItem, int newQuantity) async {
  try {
    cart.cartItems.elementAt(cart.cartItems.indexOf(oldItem)).quantity =
        newQuantity;
    cart.cartItems.elementAt(cart.cartItems.indexOf(oldItem)).price =
        cart.cartItems.elementAt(cart.cartItems.indexOf(oldItem)).unitPrice *
            newQuantity;
    List<Map<String, dynamic>> cartItemsAsMap = [];
    cart.cartItems.forEach(
      (element) => cartItemsAsMap.add(
        {
          'itemId': element.itemId,
          'price': element.price,
          'productId': element.productId,
          'quantity': element.quantity,
          'unitPrice': element.unitPrice,
        },
      ),
    );

    await FirebaseFirestore.instance
        .collection('carts/${FirebaseAuth.instance.currentUser.uid}')
        .doc('${oldItem.itemId}')
        .set(
      {
        'userId': FirebaseAuth.instance.currentUser.uid,
        'items': cartItemsAsMap,
      },
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
