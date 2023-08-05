import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/routes/routes.dart';
import 'package:parallel_37/app/presentation/screens/auth_screens/password_reset_screen.dart';

import '../../presentation/screens/auth_screens/sign_in_screen.dart';
import '../../presentation/screens/auth_screens/sign_up_screen.dart';

final appRoutes = <String, WidgetBuilder>{
  // authentication
  Routes.signIn: (context) => const SignInScreen(),
  Routes.signUp: (context) => const SignUpScreen(),
  Routes.passwordReset: (context) => const PasswordResetScreen(),
};
