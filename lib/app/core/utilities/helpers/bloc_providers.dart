import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/features/inventory/presentation/cubits/add_category_cubit/add_category_cubit.dart';

import '../../../features/authentication/presentation/cubits/auth_notifiers/login_cubit/login_cubit.dart';
import '../../../features/authentication/presentation/cubits/auth_notifiers/verify_auth_cubit/verify_auth_cubit.dart';
import '../services/di_service.dart';

blocProviders() {
  return [
    BlocProvider(create: (_) => sl<LoginCubit>()),
    BlocProvider(create: (_) => sl<VerifyAuthCubit>()),
    BlocProvider(create: (_) => sl<AddCategoryCubit>())
  ];
}
