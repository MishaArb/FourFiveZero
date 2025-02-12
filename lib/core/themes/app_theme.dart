import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_bar_theme.dart';
import 'app_card_theme.dart';
import 'app_text_theme.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData darkAppTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.darkGrayBlue29,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return ThemeData(
      useMaterial3: true,
      textTheme: AppTextTheme.darkTextTheme(),
      scaffoldBackgroundColor: AppColors.darkGrayBlue29,
      appBarTheme: AppThemeAppBar.dartAppBarTheme(),
      cardTheme: AppCardTheme.darkAppCardTheme(),
    );
  }
}
