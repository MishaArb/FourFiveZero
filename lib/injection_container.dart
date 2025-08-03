import 'package:four_five_zero/core/route/router.dart';
import 'package:four_five_zero/domain/usecase/delete_reminder_usercase.dart';
import 'package:four_five_zero/presentation/block/reminder/reminder_bloc.dart';
import 'package:four_five_zero/presentation/block/reminders_list/reminder_list_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/services/id_generator.dart';
import 'data/data_sources/sqflite_db.dart';
import 'data/repositories/media_service_repo_impl.dart';
import 'data/repositories/reminder_db_repo_impl.dart';
import 'domain/repositories/media_service_repo.dart';
import 'domain/repositories/reminder_db_repo.dart';
import 'domain/usecase/create_reminder_usercase.dart';
import 'domain/usecase/fetch_reminders_usercase.dart';
import 'domain/usecase/pick_img_usecase.dart';
import 'domain/usecase/update_reminder_usercase.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AppRouter>(AppRouter());

  ///DataBase
  getIt.registerLazySingleton<SQFLightDB>(() => SQFLightDB());

  /// Repository
  getIt.registerLazySingleton<MediaServiceRepo>(() => MediaServiceRepoImpl());
  getIt.registerLazySingleton<ReminderDBRepo>(() => ReminderDBRepoImpl(getIt()));

  /// UseCase
  getIt.registerLazySingleton<PickImageUseCase>(() => PickImageUseCase(getIt()));
  getIt.registerLazySingleton<CreateReminderUserCase>(() => CreateReminderUserCase(getIt()));
  getIt.registerLazySingleton<FetchRemindersUserCase>(() => FetchRemindersUserCase(getIt()));
  getIt.registerLazySingleton<DeleteReminderUserCase>(() => DeleteReminderUserCase(getIt()));
  getIt.registerLazySingleton<UpdateReminderUserCase>(() => UpdateReminderUserCase(getIt()));

  /// SERVICES
  getIt.registerLazySingleton<IdGeneratorService>(() => DefaultIdGeneratorService());

  ///BLOC
  getIt.registerLazySingleton<ReminderBloc>(() => ReminderBloc(getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<ReminderListBloc>(() => ReminderListBloc(getIt(), getIt()));
}
