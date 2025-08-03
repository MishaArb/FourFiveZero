import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_five_zero/core/themes/app_theme.dart';
import 'package:four_five_zero/presentation/block/reminder/reminder_bloc.dart';
import 'package:four_five_zero/presentation/block/reminders_list/reminder_list_bloc.dart';
import 'core/constants/app_text.dart';
import 'core/route/router.dart';
import 'injection_container.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReminderBloc>(
          create: (context) => getIt<ReminderBloc>(),
        ),
        BlocProvider<ReminderListBloc>(
          create: (context) => getIt<ReminderListBloc>()..add(ReminderListFetchEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: AppText.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkAppTheme(context),
            darkTheme: AppTheme.darkAppTheme(context),
            routerConfig:getIt<AppRouter>().config(),
          );
        }
      ),
    );
  }
}
