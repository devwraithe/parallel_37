import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/features/inventory/domain/inventory_repository.dart';

import '../../../../core/utilities/errors/failure.dart';

class AddCategoryUsecase {
  final InventoryRepository _repository;
  AddCategoryUsecase(this._repository);

  Future<Either<Failure, void>> call(String category) async {
    final response = await _repository.addCategory(category);
    return response.fold(
      (f) => Left(f),
      (r) => Right(r),
    );
  }
}
