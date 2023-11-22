import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';

abstract class InventoryRepository {
  Future<Either<Failure, void>> addCategory(String category);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, void>> addItem(Map<String, dynamic> data);
}
