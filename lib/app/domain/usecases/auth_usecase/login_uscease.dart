import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

import '../../../data/repositories/auth_repository_impl.dart';

class LoginUsecase {
  final AuthRepository _repo;
  LoginUsecase(this._repo);

  Future<void> execute(Map<String, dynamic> data) async {
    await _repo.login(data);
  }
}

final loginUsecaseProvider = Provider<LoginUsecase>(
  (ref) => LoginUsecase(
    ref.watch(authRepoProvider),
  ),
);
