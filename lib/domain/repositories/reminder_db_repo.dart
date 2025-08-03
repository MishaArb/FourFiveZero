import 'package:four_five_zero/core/request_result/request_result.dart';
import 'package:four_five_zero/domain/entities/reminder_entity.dart';

abstract interface class ReminderDBRepo{
 Future<RequestResult<List<ReminderEntity>>> fetchReminders();
 Future<RequestResult<ReminderEntity>> createReminder(ReminderEntity reminder);
 Future<RequestResult<ReminderEntity>> updateReminder(ReminderEntity reminder);
 Future<RequestResult<String>> deleteReminder(String id);

}