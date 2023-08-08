import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/menu_usecases/add_item_to_menu_usecase.dart';

enum AddItemToMenuState { initial, loading, success, failed }

class AddItemToMenuNotifier extends StateNotifier<AddItemToMenuState> {
  final AddItemToMenuUsecase _usecase;
  AddItemToMenuNotifier(this._usecase) : super(AddItemToMenuState.initial);

  String? error;

  Future<AddItemToMenuState> addItemToMenu(Map<String, dynamic> data) async {
    state = AddItemToMenuState.loading;
    try {
      await _usecase.execute(data);
      state = AddItemToMenuState.success;
      return state;
    } catch (e) {
      state = AddItemToMenuState.failed;
      error = e.toString();
      return state;
    }
  }
}

final addItemToMenuProvider =
    StateNotifierProvider<AddItemToMenuNotifier, AddItemToMenuState>(
  (ref) => AddItemToMenuNotifier(
    ref.watch(addItemToMenuUsecase),
  ),
);
