import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/menu_usecases/create_menu_usecase.dart';

enum CreateMenuState { initial, loading, success, failed }

class CreateMenuNotifier extends StateNotifier<CreateMenuState> {
  final CreateMenuUsecase _usecase;
  CreateMenuNotifier(this._usecase) : super(CreateMenuState.initial);

  String? error;

  Future<CreateMenuState> createMenu(Map<String, dynamic> data) async {
    state = CreateMenuState.loading;
    try {
      await _usecase.execute(data);
      state = CreateMenuState.success;
      return state;
    } catch (e) {
      state = CreateMenuState.failed;
      error = e.toString();
      return state;
    }
  }
}

final createMenuProvider =
    StateNotifierProvider<CreateMenuNotifier, CreateMenuState>(
  (ref) => CreateMenuNotifier(
    ref.watch(createMenuUsecase),
  ),
);
