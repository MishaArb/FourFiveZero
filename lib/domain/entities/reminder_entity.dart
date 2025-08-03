import 'dart:io';

import 'package:equatable/equatable.dart';

class ReminderEntity extends Equatable {
  const ReminderEntity({
    required this.id,
    required this.notificationId,
    required this.title,
    required this.repeatPeriod,
    required this.time,
    required this.timeFrom,
    required this.timeTo,
    required this.dayOfWeek,
    required this.messengerIcon,
    required this.message,
    required this.img,
    required this.isActive,
  });

  final String id;
  final int notificationId;
  final String title;
  final String repeatPeriod;
  final String time;
  final String timeFrom;
  final String timeTo;
  final int dayOfWeek;
  final int messengerIcon;
  final String message;
  final String img;
  final bool isActive;

  ReminderEntity copyWith({
    String? id,
    int? notificationId,
    String? title,
    String? repeatPeriod,
    String? time,
    String? timeFrom,
    String? timeTo,
    int? dayOfWeek,
    int? messengerIcon,
    String? message,
    String? img,
    bool? isActive,
  }) {
    return ReminderEntity(
      id: id ?? this.id,
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      repeatPeriod: repeatPeriod ?? this.repeatPeriod,
      time: time ?? this.time,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      messengerIcon: messengerIcon ?? this.messengerIcon,
      message: message ?? this.message,
      img: img ?? this.img,
      isActive: isActive ?? this.isActive,
    );
  }
  @override
  List<Object?> get props => [
        id,
        notificationId,
        title,
        repeatPeriod,
        time,
        timeFrom,
        timeTo,
        dayOfWeek,
        messengerIcon,
        message,
        img,
        isActive,
      ];
}
