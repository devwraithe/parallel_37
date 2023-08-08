import 'package:dartz/dartz.dart';

import '../../core/utilities/errors/failure.dart';
import '../../data/models/store_model.dart';

abstract class StoreRepository {
  Future<void> createStore(Map<String, dynamic> data);
  Future<Either<Failure, StoreModel>> checkStore();
  Future<String> getStoreId();
}
