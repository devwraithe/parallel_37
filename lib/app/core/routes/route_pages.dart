import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/routes/routes.dart';
import 'package:parallel_37/app/presentation/screens/vendor/create_store_screen.dart';
import 'package:parallel_37/app/presentation/screens/vendor/home_screen.dart';

import '../../presentation/screens/auth_screens/sign_in_screen.dart';
import '../../presentation/screens/vendor/create_menu_screen.dart';
import '../../presentation/screens/vendor/menu_item_screen.dart';

final appRoutes = <String, WidgetBuilder>{
  // authentication
  Routes.signIn: (context) => const SignInScreen(),

  // for the vendor
  Routes.vendorHome: (context) => const VendorHomeScreen(),
  Routes.createStore: (context) => const CreateStoreScreen(),
  Routes.createMenu: (context) => const CreateMenuScreen(),
  Routes.menuItems: (context) => const MenuItemScreen(),
};
