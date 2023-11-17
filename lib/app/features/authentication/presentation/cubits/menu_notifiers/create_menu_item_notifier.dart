import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/menu_usecases/create_menu_item_usecase.dart';

enum CreateMenuItemState { initial, loading, success, failed }

class CreateMenuItemNotifier extends StateNotifier<CreateMenuItemState> {
  final CreateMenuItemUsecase _usecase;
  CreateMenuItemNotifier(this._usecase) : super(CreateMenuItemState.initial);

  String? error;

  Future<CreateMenuItemState> handleCreateMenuItem(
      Map<String, dynamic> data) async {
    state = CreateMenuItemState.loading;
    try {
      await _usecase.execute(data);
      state = CreateMenuItemState.success;
      return state;
    } catch (e) {
      state = CreateMenuItemState.failed;
      error = e.toString();
      return state;
    }
  }
}

final createMenuItemProvider =
    StateNotifierProvider<CreateMenuItemNotifier, CreateMenuItemState>(
  (ref) => CreateMenuItemNotifier(
    ref.watch(createMenuItemUsecase),
  ),
);
