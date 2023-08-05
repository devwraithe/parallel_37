import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_theme.dart';

class UiHelpers {
  static inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.inputRadius),
      borderSide: BorderSide(
        color: color,
        width: 1.8,
      ),
    );
  }

  static loader() {
    return const CupertinoActivityIndicator(
      color: AppColors.white,
    );
  }

  static errorFlush(
    String message,
    BuildContext context,
  ) async {
    return Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextTheme.textTheme.bodyLarge?.copyWith(
          color: AppColors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.red,
      flushbarPosition: FlushbarPosition.BOTTOM,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
    )..show(context);
  }
}
