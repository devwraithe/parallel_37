import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/presentation/screens/auth_screens/login_screen.dart';

import 'core/routes/route_pages.dart';
import 'core/theme/app_theme.dart';
import 'core/utilities/helpers/bloc_providers.dart';

class BiteHub extends StatelessWidget {
  const BiteHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders(),
      child: MaterialApp(
        title: "Mostra Coffee Business",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: const LoginScreen(),
        routes: appRoutes,
      ),
    );
  }
}
