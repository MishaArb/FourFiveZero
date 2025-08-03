import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/entities/reminder_entity.dart';
import '../model/reminder_model.dart';

class SQFLightDB {
  static const int _version = 1;
  static const String _nameDB = '510_db';
  static const String _reminderTable = 'reminder';

  Future<Database> _openMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _nameDB);
    final database = await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_reminderTable('
          'id TEXT PRIMARY KEY,'
          'notificationId INTEGER,'
          'title TEXT,'
          'repeatPeriod TEXT,'
          'time TEXT,'
          'timeFrom TEXT,'
          'timeTo TEXT,'
          'dayOfWeek INTEGER,'
          'messengerIcon INTEGER,'
          'message TEXT,'
          'img TEXT,'
          'isActive INTEGER)',
        );
      },
    );
    return database;
  }

  Future<List<ReminderEntity>> fetchReminders() async {
    final db = await _openMyDatabase();
    final List<Map<String, dynamic>> resultMap = await db.query(_reminderTable);
    if (resultMap.isNotEmpty) {
      try {
        var d = resultMap
            .map((e) => ReminderModel.fromJson(e))
            .toList()
            .reversed
            .toList();
        return d;
      } catch (e, stack) {
        debugPrint('❌ Помилка при парсингу ReminderModel: $e');
        debugPrint('📍 StackTrace: $stack');
        return List.empty();
      }
    }
    return List.empty();
  }

  Future<void> createReminder(ReminderModel reminder) async {
    final db = await _openMyDatabase();
    db.insert(
      _reminderTable,
      reminder.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    final db = await _openMyDatabase();
    await db.update(
      _reminderTable,
      reminder.toJson(),
      where: 'id = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<void> deleteReminder(String itemId) async {
    final db = await _openMyDatabase();
    await db.delete(
      _reminderTable,
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }
}
