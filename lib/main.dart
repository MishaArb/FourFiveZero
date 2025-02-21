import 'package:flutter/material.dart';
import 'package:four_five_zero/core/themes/app_theme.dart';
import 'core/constants/app_text.dart';
import 'core/route/router.dart';
import 'injection_container.dart';

Future<void> main() async{
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkAppTheme(context),
      darkTheme: AppTheme.darkAppTheme(context),
      routerConfig:getIt<AppRouter>().config(),
    );
  }
}
