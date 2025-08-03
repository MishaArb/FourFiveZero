import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_property.dart';

class AppInputDecorationTheme {
  static darkTheme(BuildContext ctx) => InputDecorationTheme(
        hintStyle: Theme.of(ctx)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppColors.darkGrayBlue4E),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.red00),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.red00),
    ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppProperty.allBorderRadiusMedium,
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.darkGrayBlue3E,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppProperty.allBorderRadiusMedium,
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.darkGrayBlue4E,
          ),
        ),
        labelStyle: Theme.of(ctx)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppColors.darkGrayBlue4E),
      );
}
