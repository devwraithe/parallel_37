import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/auth_usecase/password_reset_usecase.dart';

enum PasswordResetState { initial, loading, success, failed }

class PasswordResetNotifier extends StateNotifier<PasswordResetState> {
  final PasswordResetUsecase _usecase;
  PasswordResetNotifier(this._usecase) : super(PasswordResetState.initial);

  String? error;

  Future<PasswordResetState> handleReset(Map<String, dynamic> data) async {
    state = PasswordResetState.loading;
    try {
      await _usecase.execute(data);
      state = PasswordResetState.success;
      return state;
    } catch (e) {
      state = PasswordResetState.failed;
      error = e.toString();
      return state;
    }
  }
}

final passwordResetProvider =
    StateNotifierProvider<PasswordResetNotifier, PasswordResetState>(
  (ref) => PasswordResetNotifier(
    ref.watch(passwordResetUsecaseProvider),
  ),
);
