import '../../repositories/auth_repository.dart';

class VerifyAuthUsecase {
  final AuthRepository authRepository;
  VerifyAuthUsecase(this.authRepository);

  Future<bool> execute() async {
    return await authRepository.checkAuthStatus();
  }
}
