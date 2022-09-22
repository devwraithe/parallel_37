import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/presentation/views/home.dart';
import 'package:parallel_37/src/presentation/widgets/c_text_theme.dart';
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
      theme: ThemeData(
        fontFamily: "Gilroy",
        visualDensity: VisualDensity.comfortable,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            elevation: 0,
            minimumSize: const Size(
              double.infinity,
              68,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                60,
              ),
            ),
          ),
        ),
        textTheme: theme(),
      ),
      home: const Home(),
      onGenerateRoute: routes.controller,
      initialRoute: routes.home,
    );
  }
}
