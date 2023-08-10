import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/data/models/menu_model.dart';

import '../../core/utilities/errors/failure.dart';

abstract class MenuRepository {
  Future<void> createMenu(Map<String, dynamic> data);
  Future<Either<Failure, List<MenuModel>>> getMenu(String id);
  Future<void> addItemToMenu(Map<String, dynamic> data);
  Future<String> getMenuDocId(Map<String, dynamic> data);
}
