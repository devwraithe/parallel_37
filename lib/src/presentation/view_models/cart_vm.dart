import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/core/database_helper.dart';
import 'package:parallel_37/src/data/models/cart_model.dart';

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  DatabaseHelper dbHelper = DatabaseHelper();

  Cart _newProduct = Cart();

  Cart get newPizza => _newProduct;

  List<Cart> cartItems = [];

  getCartData() async {
    cartItems = await dbHelper.getCartList();
    state = cartItems;
  }

  addPizzaToCart(Cart itemToAdd, int productId, int storeId) async {
    int itemFromCartId = 0;
    int itemFromStoreId = 0;
    cartItems = await dbHelper.getCartList();
    cartItems.forEach((Cart cartItem) => {
          itemFromCartId = cartItem.productId!,
          itemFromStoreId = cartItem.publisherId!,
        });

    if (productId == itemFromCartId && storeId == itemFromStoreId) {
      log("Product is already added!");
    } else {
      _newProduct = itemToAdd;
      dbHelper.insert(itemToAdd);
      state = [...state, itemToAdd];
    }
  }

  removePizzaFromCart(int id) async {
    dbHelper.deleteCartItem(id);
  }

  get totalPrice => _totalPrice();

  double productsPrice = 0.0;

  _totalPrice() async {
    double total = 0.0;
    cartItems = await dbHelper.getCartList();

    cartItems.forEach((Cart cartItem) => {
          total += cartItem.price!,
        });
    productsPrice = total;
    return productsPrice;
  }
}

final cartProvider =
    StateNotifierProvider.autoDispose<CartNotifier, List<Cart>>(
  (ref) {
    return CartNotifier();
  },
);
