import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/features/inventory/domain/inventory_repository.dart';

import '../../../../core/utilities/errors/failure.dart';

class GetCategoriesUsecase {
  final InventoryRepository _repository;
  GetCategoriesUsecase(this._repository);

  Future<Either<Failure, List<String>>> call() async {
    final response = await _repository.getCategories();
    return response.fold(
      (f) => Left(f),
      (r) => Right(r),
    );
  }
}
