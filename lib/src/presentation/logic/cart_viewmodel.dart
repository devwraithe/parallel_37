import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/data/cart_model.dart';
import 'package:parallel_37/src/data/database_helper.dart';

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  DatabaseHelper dbHelper = DatabaseHelper();

  Cart _newPizza = Cart();

  Cart get newPizza => _newPizza;

  List<Cart> cartItems = [];

  getCartData() async {
    cartItems = await dbHelper.getCartList();
    state = cartItems;
  }

  addPizzaToCart(Cart itemToAdd) {
    _newPizza = itemToAdd;
    dbHelper.insert(itemToAdd);
    state = [...state, itemToAdd];
  }

  removePizzaFromCart(int id) {
    dbHelper.deleteCartItem(id);
  }
}

final cartProvider =
    StateNotifierProvider.autoDispose<CartNotifier, List<Cart>>((ref) {
  return CartNotifier();
});
