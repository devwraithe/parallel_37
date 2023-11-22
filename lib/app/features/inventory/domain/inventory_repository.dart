import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';

abstract class InventoryRepository {
  Future<Either<Failure, void>> addCategory(String category);
}
