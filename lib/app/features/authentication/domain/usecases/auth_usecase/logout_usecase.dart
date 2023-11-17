import '../../repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository _repo;
  LogoutUsecase(this._repo);

  Future<void> execute() async {
    await _repo.logout();
  }
}
