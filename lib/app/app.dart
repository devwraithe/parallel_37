import 'package:flutter/material.dart';
import 'package:parallel_37/app/presentation/screens/auth_screens/sign_up_screen.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

class BiteHub extends StatelessWidget {
  const BiteHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BiteHub",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const SignUpScreen(),
      routes: appRoutes,
    );
  }
}
