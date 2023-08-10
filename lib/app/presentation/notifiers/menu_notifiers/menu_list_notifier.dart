import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/data/models/menu_model.dart';
import 'package:parallel_37/app/domain/usecases/menu_usecases/get_menu_list_usecase.dart';

enum MenuListStates { initial, failed, complete, loading }

class MenuListNotifier extends StateNotifier<MenuListStates> {
  final MenuListUsecase _usecase;

  MenuListNotifier(this._usecase) : super(MenuListStates.initial);

  String? error;
  List<MenuModel> menuList = [];

  Future<void> showMenuList(String id) async {
    state = MenuListStates.loading;
    try {
      final result = await _usecase.execute(id);
      result.fold(
        (failure) {
          state = MenuListStates.failed;
          error = failure.message;
          print("[ERROR IN NOTIFIER] ${error.toString()}");
          error;
        },
        (menu) {
          state = MenuListStates.complete;
          menuList = menu;
          menuList;
        },
      );
    } catch (e) {
      state = MenuListStates.failed;
      error = e.toString();
    }
  }
}

// notifier provider
final menuListProvider = StateNotifierProvider.autoDispose
    .family<MenuListNotifier, MenuListStates, String>(
  (ref, id) {
    final notifier = MenuListNotifier(
      ref.watch(menuListUsecase),
    );
    notifier.showMenuList(id);
    return notifier;
  },
);
