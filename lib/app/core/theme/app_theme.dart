import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/theme/button_theme.dart';
import 'package:parallel_37/app/core/theme/input_theme.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import 'color_scheme.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: Constants.fontFamily,
    colorScheme: AppColorScheme.lightColorScheme,
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.background,
    textTheme: AppTextTheme.textTheme,
    inputDecorationTheme: AppInputDecorationTheme.inputDecoration,
    filledButtonTheme: AppButtonTheme.filledButtonTheme,
  );
}
