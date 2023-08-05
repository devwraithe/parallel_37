import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/auth_usecase/create_account_usecase.dart';

enum CreateAcctState { initial, loading, success, failed }

class CreateAcctNotifier extends StateNotifier<CreateAcctState> {
  final CreateAccountUsecase _usecase;
  CreateAcctNotifier(this._usecase) : super(CreateAcctState.initial);

  String? error;

  Future<CreateAcctState> createAcct(Map<String, dynamic> data) async {
    state = CreateAcctState.loading;
    try {
      await _usecase.execute(data);
      state = CreateAcctState.success;
      return state;
    } catch (e) {
      state = CreateAcctState.failed;
      error = e.toString();
      return state;
    }
  }
}

final createAcctProvider =
    StateNotifierProvider<CreateAcctNotifier, CreateAcctState>(
  (ref) => CreateAcctNotifier(
    ref.watch(createAcctUsecase),
  ),
);
