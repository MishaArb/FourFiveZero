import 'package:four_five_zero/core/request_result/request_result.dart';
import 'package:four_five_zero/data/model/reminder_model.dart';
import 'package:four_five_zero/domain/repositories/reminder_db_repo.dart';

import '../../domain/entities/reminder_entity.dart';
import '../data_sources/sqflite_db.dart';

class ReminderDBRepoImpl implements ReminderDBRepo {
  ReminderDBRepoImpl(this.db);

  final SQFLightDB db;

  @override
  Future<RequestResult<List<ReminderEntity>>> fetchReminders() async {
    try {
      final fetchResult = await db.fetchReminders();
      return RequestSuccess(fetchResult);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<ReminderEntity>> createReminder(
      ReminderEntity reminder) async {
    final reminderEntity = ReminderModel.fromEntity(reminder);
    try {
      await db.createReminder(reminderEntity);
      return RequestSuccess(reminderEntity);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<ReminderEntity>> updateReminder(
      ReminderEntity reminder) async {
    final reminderEntity = ReminderModel.fromEntity(reminder);
    try {
      await db.updateReminder(reminderEntity);
      return RequestSuccess(reminderEntity);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<String>> deleteReminder(String id) async {
    try {
      await db.deleteReminder(id);
      return RequestSuccess(id);
    } catch (e) {
      return RequestError(e.toString());
    }
  }
}
