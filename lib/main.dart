import 'package:flutter/material.dart';
import 'package:four_five_zero/core/themes/app_theme.dart';
import 'core/constants/app_text.dart';
import 'core/route/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkAppTheme(context),
      darkTheme: AppTheme.darkAppTheme(context),
      routerConfig: _appRouter.config(),
    );
  }
}
