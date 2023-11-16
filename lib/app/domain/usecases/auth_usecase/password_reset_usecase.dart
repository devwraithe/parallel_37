import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

import '../../../data/repositories/auth_repository_impl.dart';

class PasswordResetUsecase {
  final AuthRepository _repo;
  PasswordResetUsecase(this._repo);

  Future<void> execute(Map<String, dynamic> data) async {
    await _repo.passwordReset(data);
  }
}

final passwordResetUsecaseProvider = Provider<PasswordResetUsecase>(
  (ref) => PasswordResetUsecase(
    ref.watch(authRepoProvider),
  ),
);
