import 'package:flutter/material.dart';
import 'package:parallel_37/src/presentation/views/shopping_bag.dart';
import 'package:parallel_37/src/presentation/views/home.dart';
import 'package:parallel_37/src/presentation/views/store_details.dart';

const String home = "/";
const String info = "/info";
const String bag = "/bag";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case home:
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );
    case info:
      return MaterialPageRoute(
        builder: (context) => const StoreDetails(),
      );
    case bag:
      return MaterialPageRoute(
        builder: (context) => const Bag(),
      );
    default:
      throw ("route is unavailable :(");
  }
}
