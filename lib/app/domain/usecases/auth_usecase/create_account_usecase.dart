import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

import '../../../data/repositories/auth_repository_impl.dart';

class CreateAccountUsecase {
  final AuthRepository _repo;
  CreateAccountUsecase(this._repo);

  Future<User?> execute(Map<String, dynamic> data) async {
    return await _repo.createAccount(data);
  }
}

// provider
final createAcctUsecase = Provider<CreateAccountUsecase>(
  (ref) => CreateAccountUsecase(
    ref.watch(authRepoProvider),
  ),
);
