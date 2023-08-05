import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/data/data_sources/local_data_source_impl.dart';
import 'package:parallel_37/src/data/repositories/store_repository_impl.dart';
import 'package:parallel_37/src/domain/entities/store.dart';
import 'package:parallel_37/src/domain/use_cases/get_might_like_stores.dart';
import 'package:http/http.dart' as http;
import 'package:parallel_37/src/domain/use_cases/get_popular_stores.dart';

final storesProvider = FutureProvider.autoDispose<List<Store>>(
  (ref) async {
    final result = await ref.watch(storeRepoProvider).execute();
    return result.fold(
      (dynamic failure) {
        return failure;
      },
      (result) {
        return result;
      },
    );
  },
);

final storeRepoProvider = Provider<GetMightLikeStores>((ref) {
  return GetMightLikeStores(
    StoreRepositoryImpl(
      LocalDataSourceImpl(
        http.Client(),
      ),
    ),
  ); // declared elsewhere
});

final popularStoresProvider = FutureProvider.autoDispose<List<Store>>(
  (ref) async {
    final result = await ref.watch(storeRepoProvider).execute();
    return result.fold(
      (dynamic failure) {
        return failure;
      },
      (result) {
        return result;
      },
    );
  },
);

final popularStoresRepoProvider = Provider<GetPopularStores>((ref) {
  return GetPopularStores(
    StoreRepositoryImpl(
      LocalDataSourceImpl(
        http.Client(),
      ),
    ),
  ); // declared elsewhere
});
