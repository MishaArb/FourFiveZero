import 'package:four_five_zero/core/usecase/usecase.dart';

import '../../core/request_result/request_result.dart';
import '../repositories/reminder_db_repo.dart';

class DeleteReminderUserCase implements UseCase<RequestResult<String>, String>{
  DeleteReminderUserCase(this.reminderDBRepo);

  final ReminderDBRepo reminderDBRepo;

  @override
  Future<RequestResult<String>> call({String? params})async {
   return await reminderDBRepo.deleteReminder(params!);
  }
}