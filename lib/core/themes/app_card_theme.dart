import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_property.dart';

class AppCardTheme {
  static darkTheme() => CardTheme(
        clipBehavior: Clip.antiAlias,
        color: AppColors.darkGrayBlue3E,
        surfaceTintColor: Colors.green,
        elevation: 0,
        margin: AppProperty.paddingTopRightBottomMedium,
        shape: RoundedRectangleBorder(
          borderRadius: AppProperty.allBorderRadiusLarge,
        ),
      );
}
