import 'package:four_five_zero/core/request_result/request_result.dart';
import 'package:four_five_zero/core/usecase/usecase.dart';
import 'package:four_five_zero/domain/entities/reminder_entity.dart';

import '../repositories/reminder_db_repo.dart';

class UpdateReminderUserCase
    implements UseCase<RequestResult<ReminderEntity>, ReminderEntity> {
  UpdateReminderUserCase(this.reminderDBRepo);

  final ReminderDBRepo reminderDBRepo;

  @override
  Future<RequestResult<ReminderEntity>> call({ReminderEntity? params}) async {
    return await reminderDBRepo.updateReminder(params!);
  }
}
