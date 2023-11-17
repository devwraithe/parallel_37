import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/routes/routes.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/vendor/create_menu_screen.dart';
import '../../features/authentication/presentation/screens/vendor/create_store_screen.dart';
import '../../features/authentication/presentation/screens/vendor/home_screen.dart';
import '../../features/authentication/presentation/screens/vendor/menu_item_screen.dart';

final appRoutes = <String, WidgetBuilder>{
  // authentication
  Routes.signIn: (context) => const LoginScreen(),

  // for the vendor
  Routes.vendorHome: (context) => const VendorHomeScreen(),
  Routes.createStore: (context) => const CreateStoreScreen(),
  Routes.createMenu: (context) => const CreateMenuScreen(),
  Routes.menuItems: (context) => const MenuItemScreen(),
};
