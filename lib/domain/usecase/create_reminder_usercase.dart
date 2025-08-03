import 'package:four_five_zero/core/request_result/request_result.dart';
import 'package:four_five_zero/core/usecase/usecase.dart';
import 'package:four_five_zero/domain/repositories/reminder_db_repo.dart';
import '../entities/reminder_entity.dart';

class CreateReminderUserCase
    implements UseCase<RequestResult<ReminderEntity>, ReminderEntity> {
  CreateReminderUserCase(this.reminderDBRepo);

  final ReminderDBRepo reminderDBRepo;

  @override
  Future<RequestResult<ReminderEntity>> call({ReminderEntity? params}) async {
    return await reminderDBRepo.createReminder(params!);
  }
}
