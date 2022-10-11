import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/config/theme.dart';
import 'package:parallel_37/src/presentation/views/home.dart';
import "src/config/routes.dart" as routes;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const ProviderScope(
        child: Parallel37(),
      ),
    );
  });
}

class Parallel37 extends StatelessWidget {
  const Parallel37({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallel 37',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: themeData,
      home: const Home(),
      onGenerateRoute: routes.controller,
      initialRoute: routes.home,
    );
  }
}
