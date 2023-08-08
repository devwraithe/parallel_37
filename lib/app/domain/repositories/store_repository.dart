abstract class StoreRepository {
  Future<void> createStore(Map<String, dynamic> data);
  Future<String> getStoreId();
}
