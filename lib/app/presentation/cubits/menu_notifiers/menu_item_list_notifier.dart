import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/menu_item_model.dart';
import '../../../domain/usecases/menu_usecases/menu_item_list_usecase.dart';

enum MenuItemListStates { initial, failed, complete, loading }

class MenuItemListNotifier extends StateNotifier<MenuItemListStates> {
  final MenuItemListUsecase _usecase;

  MenuItemListNotifier(this._usecase) : super(MenuItemListStates.initial);

  String? error;
  List<MenuItemModel> menuItemList = [];

  Future<void> showMenuList(Map<String, dynamic> data) async {
    state = MenuItemListStates.loading;
    try {
      final result = await _usecase.execute(data);
      result.fold(
        (failure) {
          state = MenuItemListStates.failed;
          error = failure.message;
          print("[ERROR IN NOTIFIER] ${error.toString()}");
          error;
        },
        (menu) {
          state = MenuItemListStates.complete;
          menuItemList = menu;
          menuItemList;
        },
      );
    } catch (e) {
      state = MenuItemListStates.failed;
      error = e.toString();
    }
  }
}

// notifier provider
final menuItemListProvider = StateNotifierProvider.autoDispose
    .family<MenuItemListNotifier, MenuItemListStates, Map<String, dynamic>>(
  (ref, data) {
    final notifier = MenuItemListNotifier(
      ref.watch(menuItemListUsecase),
    );
    notifier.showMenuList(data);
    return notifier;
  },
);
