import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/features/inventory/domain/inventory_repository.dart';

import '../../../../core/utilities/errors/failure.dart';

class AddItemUsecase {
  final InventoryRepository _repository;
  AddItemUsecase(this._repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> data) async {
    final response = await _repository.addItem(data);
    return response.fold(
      (f) => Left(f),
      (r) => Right(r),
    );
  }
}
