import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/features/authentication/presentation/cubits/auth_notifiers/verify_auth_cubit/verify_auth_state.dart';

import '../../../../domain/usecases/auth_usecase/auth_status_verify_usecase.dart';

class VerifyAuthCubit extends Cubit<VerifyAuthState> {
  final VerifyAuthUsecase _usecase;

  VerifyAuthCubit(this._usecase) : super(VerifyAuthInitial());

  Future<void> checkLoginStatus() async {
    emit(VerifyAuthLoading());
    try {
      final userNull = await _usecase.execute();
      debugPrint("Is the user null? $userNull");
      if (userNull == false) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }
}
