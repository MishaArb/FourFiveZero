import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_font.dart';

class AppTextTheme {
  static darkTextTheme() => const TextTheme(
        titleLarge: TextStyle(
          fontSize: 35,
          fontFamily: AppFont.montserratBold700,
          color: AppColors.whiteFF,
        ),
        titleSmall: TextStyle(
          fontSize: 17,
          fontFamily: AppFont.montserratBold700,
          color: AppColors.whiteFF,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontFamily: AppFont.montserratMedium500,
          color: AppColors.whiteFF,
        ),
      );
}
