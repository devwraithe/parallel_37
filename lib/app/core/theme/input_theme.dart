import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/helpers/ui_helpers.dart';

import 'app_colors.dart';

class AppInputDecorationTheme {
  static final inputDecoration = InputDecorationTheme(
    hintStyle: AppTextTheme.textTheme.bodyLarge?.copyWith(
      height: 1.34,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(vertical: 20),
    isDense: true,
    enabledBorder: UiHelpers.inputBorder(AppColors.grey),
    focusedBorder: UiHelpers.inputBorder(AppColors.black),
    errorBorder: UiHelpers.inputBorder(AppColors.red),
    focusedErrorBorder: UiHelpers.inputBorder(AppColors.red),
    errorStyle: AppTextTheme.textTheme.bodyLarge?.copyWith(
      color: AppColors.red,
    ),
  );
}
