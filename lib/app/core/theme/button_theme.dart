import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import 'app_colors.dart';

@immutable
class AppButtonTheme {
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
}
