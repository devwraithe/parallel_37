import 'package:parallel_37/app/features/inventory/data/inventory_repository_impl.dart';
import 'package:parallel_37/app/features/inventory/domain/inventory_repository.dart';

import '../../../features/inventory/domain/usecases/add_category_usecase.dart';
import '../../../features/inventory/presentation/cubits/add_category_cubit/add_category_cubit.dart';
import '../services/di_service.dart';

void addCategoryInjector() {
  regSingleton(() => AddCategoryCubit(sl()));
  regSingleton(() => AddCategoryUsecase(sl()));
}

// Core injector for repo
void inventoryInjector() {
  regSingleton<InventoryRepository>(() => InventoryRepositoryImpl());
}
