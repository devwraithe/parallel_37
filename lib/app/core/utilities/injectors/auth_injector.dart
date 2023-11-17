import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../../features/authentication/domain/repositories/auth_repository.dart';
import '../../../features/authentication/domain/usecases/auth_usecase/auth_status_verify_usecase.dart';
import '../../../features/authentication/domain/usecases/auth_usecase/login_uscease.dart';
import '../../../features/authentication/presentation/cubits/auth_notifiers/login_cubit/login_cubit.dart';
import '../../../features/authentication/presentation/cubits/auth_notifiers/verify_auth_cubit/verify_auth_cubit.dart';
import '../services/di_service.dart';

void loginInjector() {
  regSingleton(() => LoginCubit(sl()));
  regSingleton(() => LoginUsecase(sl()));
}

void verifyAuthInjector() {
  regSingleton(() => VerifyAuthCubit(sl()));
  regSingleton(() => VerifyAuthUsecase(sl()));
}

// Core injector for repo
void authInjector() {
  regSingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  regSingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
