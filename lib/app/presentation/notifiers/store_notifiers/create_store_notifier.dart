import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/store_usecases/create_store_usecase.dart';

enum CreateStoreState { initial, loading, success, failed }

class CreateStoreNotifier extends StateNotifier<CreateStoreState> {
  final CreateStoreUsecase _usecase;
  CreateStoreNotifier(this._usecase) : super(CreateStoreState.initial);

  String? error;

  Future<CreateStoreState> createStore(Map<String, dynamic> data) async {
    state = CreateStoreState.loading;
    try {
      await _usecase.execute(data);
      state = CreateStoreState.success;
      return state;
    } catch (e) {
      state = CreateStoreState.failed;
      error = e.toString();
      return state;
    }
  }
}

final createStoreProvider =
    StateNotifierProvider<CreateStoreNotifier, CreateStoreState>(
  (ref) => CreateStoreNotifier(
    ref.watch(createStoreUsecase),
  ),
);
