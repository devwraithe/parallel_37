import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/domain/usecases/auth_usecase/auth_status_verify_usecase.dart';
import 'package:parallel_37/app/presentation/screens/auth_screens/sign_in_screen.dart';
import 'package:parallel_37/app/presentation/screens/vendor/home_screen.dart';

import 'core/routes/route_pages.dart';
import 'core/theme/app_theme.dart';
import 'core/utilities/helpers/ui_helpers.dart';

class BiteHub extends ConsumerWidget {
  const BiteHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyAuthStatus = ref.read(verifyAuthProvider);

    return MaterialApp(
      title: "BiteHub",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: FutureBuilder<bool>(
        future: verifyAuthStatus.execute(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: UiHelpers.loader(),
            );
          } else {
            if (snapshot.hasData && snapshot.data!) {
              return const VendorHomeScreen();
            } else {
              return const SignInScreen();
            }
          }
        },
      ),
      routes: appRoutes,
    );
  }
}
