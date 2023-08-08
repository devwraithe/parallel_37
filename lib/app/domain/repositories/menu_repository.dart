abstract class MenuRepository {
  Future<void> createMenu(Map<String, dynamic> data);
  Future<void> addItemToMenu(Map<String, dynamic> data);
  Future<String> getMenuDocId(Map<String, dynamic> data);
}
