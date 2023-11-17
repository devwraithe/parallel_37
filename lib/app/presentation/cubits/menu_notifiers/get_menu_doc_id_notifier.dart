import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/menu_usecases/get_menu_doc_id.dart';

enum GetMenuDocIdState { initial, loading, loaded, failed }

class GetMenuDocIdNotifier extends StateNotifier<GetMenuDocIdState> {
  final GetMenuDocIdUsecase _usecase;
  GetMenuDocIdNotifier(this._usecase) : super(GetMenuDocIdState.initial);

  Future<String> getMenuDocId(Map<String, dynamic> data) async {
    state = GetMenuDocIdState.loading;
    try {
      final result = await _usecase.execute(data);
      state = GetMenuDocIdState.loaded;
      return result;
    } catch (e) {
      state = GetMenuDocIdState.failed;
      return e.toString();
    }
  }
}

final getMenuDocIdProvider =
    StateNotifierProvider<GetMenuDocIdNotifier, GetMenuDocIdState>(
  (ref) => GetMenuDocIdNotifier(
    ref.watch(getMenuDocIdUsecase),
  ),
);
