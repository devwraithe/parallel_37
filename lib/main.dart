import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parallel_37/app/app.dart';

import 'app/core/utilities/services/di_service.dart' as di;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init();

  runApp(const BiteHub());
}
