import 'package:parallel_37/src/data/models/store_model.dart';

abstract class LocalDataSource {
  Future<List<StoreModel>> getMightLikeStores();
  Future<List<StoreModel>> popularStores();
}
