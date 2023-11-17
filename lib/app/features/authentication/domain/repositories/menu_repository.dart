import 'package:dartz/dartz.dart';

import '../../../../core/utilities/errors/failure.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/menu_model.dart';

abstract class MenuRepository {
  Future<void> createMenu(Map<String, dynamic> data);
  Future<Either<Failure, List<MenuModel>>> getMenu(String id);
  Future<void> createMenuItem(Map<String, dynamic> data);
  Future<Either<Failure, List<MenuItemModel>>> getMenuItems(
      Map<String, dynamic> data);
  Future<void> addItemToMenu(Map<String, dynamic> data);
  Future<String> getMenuDocId(Map<String, dynamic> data);
}
