import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

class VerifyAuthUsecase {
  final AuthRepository authRepository;
  VerifyAuthUsecase(this.authRepository);

  Future<bool> execute() async {
    return await authRepository.checkAuthStatus();
  }
}
