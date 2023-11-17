import 'package:dartz/dartz.dart';

import '../../../../../core/utilities/errors/failure.dart';
import '../../repositories/auth_repository.dart';

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
