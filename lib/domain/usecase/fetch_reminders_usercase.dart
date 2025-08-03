import 'package:four_five_zero/core/usecase/no_params.dart';

import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../entities/reminder_entity.dart';
import '../repositories/reminder_db_repo.dart';

class FetchRemindersUserCase
    implements UseCase<RequestResult<List<ReminderEntity>>, NoParams> {
  FetchRemindersUserCase(this.reminderDBRepo);

  final ReminderDBRepo reminderDBRepo;

  @override
  Future<RequestResult<List<ReminderEntity>>> call({NoParams? params}) async {
    return await reminderDBRepo.fetchReminders();
  }
}
