import 'package:get_it/get_it.dart';

import '../injectors/auth_injector.dart';

final sl = GetIt.instance;

regFactory<T extends Object>(T Function() factFunc) {
  sl.registerFactory(factFunc);
}

regSingleton<T extends Object>(T Function() factFunc) {
  sl.registerLazySingleton(factFunc);
}

void init() {
  // auth injectors
  loginInjector();
  verifyAuthInjector();

  // base injectors
  authInjector();
}
