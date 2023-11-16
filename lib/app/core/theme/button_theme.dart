import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import 'app_colors.dart';

@immutable
class AppButtonTheme {
  // filled button
  static final filledButtonTheme = FilledButtonThemeData(
    style: AppButtonTheme.filledButtonStyle,
  );
  static final filledButtonStyle = FilledButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Constants.inputRadius),
    ),
    textStyle: AppTextTheme.textTheme.titleLarge?.copyWith(
      fontFamily: Constants.fontFamily,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    backgroundColor: AppColors.blue,
    minimumSize: const Size(double.infinity, 58),
  );

  // outlined button
  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: AppButtonTheme.outlinedButtonStyle,
  );
  static final outlinedButtonStyle = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Constants.inputRadius),
    ),
    textStyle: AppTextTheme.textTheme.titleLarge?.copyWith(
      fontFamily: Constants.fontFamily,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    side: const BorderSide(
      color: AppColors.blue,
      width: 1.26,
    ),
    minimumSize: const Size(double.infinity, 58),
  );
}
