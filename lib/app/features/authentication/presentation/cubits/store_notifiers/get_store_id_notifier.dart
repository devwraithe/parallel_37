import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/store_usecases/get_store_id_usecase.dart';

enum GetStoreIdState { initial, loading, loaded, failed }

class GetStoreIdNotifier extends StateNotifier<GetStoreIdState> {
  final GetStoreIdUsecase _usecase;
  GetStoreIdNotifier(this._usecase) : super(GetStoreIdState.initial);

  Future<String> getStoreId() async {
    state = GetStoreIdState.loading;
    try {
      final result = await _usecase.execute();
      state = GetStoreIdState.loaded;
      return result;
    } catch (e) {
      state = GetStoreIdState.failed;
      return e.toString();
    }
  }
}

final getStoreIdProvider =
    StateNotifierProvider<GetStoreIdNotifier, GetStoreIdState>(
  (ref) => GetStoreIdNotifier(
    ref.watch(getStoreIdUsecase),
  ),
);
