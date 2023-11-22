import 'package:parallel_37/app/features/inventory/data/inventory_repository_impl.dart';
import 'package:parallel_37/app/features/inventory/domain/inventory_repository.dart';

import '../../../features/inventory/domain/usecases/add_category_usecase.dart';
import '../../../features/inventory/domain/usecases/add_item_usecase.dart';
import '../../../features/inventory/domain/usecases/get_categories_usecase.dart';
import '../../../features/inventory/presentation/add_item/add_item_cubit/add_item_cubit.dart';
import '../../../features/inventory/presentation/cubits/add_category_cubit/add_category_cubit.dart';
import '../../../features/inventory/presentation/cubits/get_categories_cubit/get_categories_cubit.dart';
import '../services/di_service.dart';

void addCategoryInjector() {
  regSingleton(() => AddCategoryCubit(sl()));
  regSingleton(() => AddCategoryUsecase(sl()));
}

void getCategoriesInjector() {
  regSingleton(() => GetCategoriesCubit(sl()));
  regSingleton(() => GetCategoriesUsecase(sl()));
}

void addItemInjector() {
  regSingleton(() => AddItemCubit(sl()));
  regSingleton(() => AddItemUsecase(sl()));
}

// Core injector for repo
void inventoryInjector() {
  regSingleton<InventoryRepository>(() => InventoryRepositoryImpl());
}
