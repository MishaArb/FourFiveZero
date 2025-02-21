import 'package:four_five_zero/core/route/router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt ()async{
  getIt.registerSingleton<AppRouter>(AppRouter());
}