import 'package:flutter/material.dart';
import 'package:four_five_zero/core/themes/app_theme.dart';
import 'core/constants/app_text.dart';
import 'presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkAppTheme(),
      darkTheme: AppTheme.darkAppTheme(),
      home: const HomeScreen()
    );
  }
}
