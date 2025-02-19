import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_bar_theme.dart';
import 'app_card_theme.dart';
import 'app_input_decoration_theme.dart';
import 'app_text_theme.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData darkAppTheme(BuildContext ctx) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.darkGrayBlue29,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return ThemeData(
      useMaterial3: true,
      textTheme: AppTextTheme.darkTheme(),
      scaffoldBackgroundColor: AppColors.darkGrayBlue29,
      appBarTheme: AppThemeAppBar.darkTheme(),
      cardTheme: AppCardTheme.darkTheme(),
      inputDecorationTheme: AppInputDecorationTheme.darkTheme(ctx),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.whiteFF,
        selectionColor: AppColors.darkGrayBlue4E,
        selectionHandleColor: AppColors.whiteFF,
      ),
      timePickerTheme: const TimePickerThemeData(
        hourMinuteTextColor: AppColors.blueF3,
        dialTextColor: AppColors.blueF3,
        dialBackgroundColor: AppColors.darkGrayBlue4E,
        backgroundColor: AppColors.darkGrayBlue3E,
        dialHandColor: AppColors.yellow07,
        hourMinuteColor: AppColors.darkGrayBlue4E,
        entryModeIconColor: AppColors.whiteFF,
        helpTextStyle: TextStyle(
          color: AppColors.whiteFF,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(AppColors.whiteFF),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
