import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/presentation/cubits/auth_notifiers/login_cubit/login_cubit.dart';
import 'package:parallel_37/app/presentation/cubits/auth_notifiers/verify_auth_cubit/verify_auth_cubit.dart';

import '../services/di_service.dart';

blocProviders() {
  return [
    BlocProvider(create: (_) => sl<LoginCubit>()),
    BlocProvider(create: (_) => sl<VerifyAuthCubit>())
  ];
}
