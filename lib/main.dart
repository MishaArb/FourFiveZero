import 'package:flutter/material.dart';
import 'package:four_five_zero/core/themes/app_theme.dart';
import 'package:four_five_zero/presentation/pages/create_edit_reminder_screen.dart';
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
      theme: AppTheme.darkAppTheme(context),
      darkTheme: AppTheme.darkAppTheme(context),
      home:
      //MessengerPickScreen()
      CreateEditReminderScreen()
      //const HomeScreen()
    );
  }
}
