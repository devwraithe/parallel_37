import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

import '../../../data/repositories/auth_repository_impl.dart';

class LogoutUsecase {
  final AuthRepository _repo;
  LogoutUsecase(this._repo);

  Future<void> execute() async {
    await _repo.signOut();
  }
}

final logoutUsecaseProvider = Provider<LogoutUsecase>(
  (ref) => LogoutUsecase(
    ref.watch(authRepoProvider),
  ),
);
