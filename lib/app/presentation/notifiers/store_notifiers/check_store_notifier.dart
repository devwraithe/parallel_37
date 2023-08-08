import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/data/models/store_model.dart';
import 'package:parallel_37/app/domain/usecases/store_usecases/check_store_usecase.dart';

enum CheckStoreStates { initial, failed, complete, loading }

class CheckStoreNotifier extends StateNotifier<CheckStoreStates> {
  final CheckStoreUsecase _usecase;
  CheckStoreNotifier(this._usecase) : super(CheckStoreStates.initial);

  String? error;
  StoreModel? storeModel;

  Future<void> handleCheckStore() async {
    state = CheckStoreStates.loading;
    try {
      final result = await _usecase.execute();
      result.fold(
        (failure) {
          state = CheckStoreStates.failed;
          error = failure.message;
          print("[ERROR IN NOTIFIER] ${error.toString()}");
          error;
        },
        (store) {
          state = CheckStoreStates.complete;
          storeModel = store;
          storeModel;
        },
      );
    } catch (e) {
      state = CheckStoreStates.failed;
      error = e.toString();
    }
  }

  // Future<Either<Failure, StoreModel>> handleCheckStore() async {
  //   state = CheckStoreState.loading;
  //   try {
  //     final result = await _usecase.execute();
  //     result.fold(
  //       (failure) {
  //         state = CheckStoreState.failed;
  //         throw Left(failure);
  //       },
  //       (response) {
  //         state = CheckStoreState.loaded;
  //         return Right(response);
  //       },
  //     );
  //   } catch (e) {
  //     state = CheckStoreState.failed;
  //     throw Left(Failure(e.toString()));
  //   }
  //   r
  // }
}

// final checkStoreProvider = FutureProvider.autoDispose<AsyncValue<StoreModel>>(
//   (ref) async {
//     final notifier = CheckStoreNotifier(
//       ref.watch(checkStoreUsecase),
//     );
//     await notifier.fetchStoreDetails();
//     return notifier.state;
//   },
// );

// notifier provider
final checkStoreProvider =
    StateNotifierProvider<CheckStoreNotifier, CheckStoreStates>(
  (ref) {
    final notifier = CheckStoreNotifier(
      ref.watch(checkStoreUsecase),
    );
    notifier.handleCheckStore();
    return notifier;
  },
);
