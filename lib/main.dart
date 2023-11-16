import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/app.dart';

import 'app/core/utilities/helpers/shared_prefs_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize the shared preferences
  final sharedPreferencesHelper = SharedPreferencesHelper();
  await sharedPreferencesHelper.init();

  runApp(
    const ProviderScope(
      child: BiteHub(),
    ),
  );
}
