import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

import '../../../data/repositories/auth_repository_impl.dart';

class AuthStatusVerifyUsecase {
  final AuthRepository authRepository;
  AuthStatusVerifyUsecase(this.authRepository);

  Future<bool> execute() async {
    return await authRepository.checkAuthStatus();
  }
}

final verifyAuthProvider = Provider<AuthStatusVerifyUsecase>(
  (ref) => AuthStatusVerifyUsecase(
    ref.watch(authRepoProvider),
  ),
);
