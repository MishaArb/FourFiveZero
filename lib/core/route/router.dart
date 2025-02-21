import 'package:auto_route/auto_route.dart';

import '../../presentation/pages/create_edit_reminder_screen.dart';
import '../../presentation/pages/home_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(
            page: CreateEditReminderRoute.page,
            path: '/createEditReminderScreen'),
      ];
}
