import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/domain/repositories/auth_repository.dart';

import '../../../core/utilities/errors/failure.dart';

class LoginUsecase {
  final AuthRepository _repository;
  LoginUsecase(this._repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> data) async {
    final response = await _repository.login(data);
    return response.fold(
      (failure) => Left(failure),
      (user) => const Right(null),
    );
  }
}
