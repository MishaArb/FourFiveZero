import 'package:four_five_zero/domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required super.id,
    required super.notificationId,
    required super.title,
    required super.repeatPeriod,
    required super.time,
    required super.timeFrom,
    required super.timeTo,
    required super.dayOfWeek,
    required super.messengerIcon,
    required super.message,
    required super.img,
    required super.isActive,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'notificationId': notificationId,
        'title': title,
        'repeatPeriod': repeatPeriod,
        'time': time,
        'timeFrom': timeFrom,
        'timeTo': timeTo,
        'dayOfWeek': dayOfWeek,
        'messengerIcon': messengerIcon,
        'message': message,
        'img': img,
        'isActive': isActive ? 1 : 0,
      };

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json['id'],
        notificationId: json['notificationId'],
        title: json['title'],
        repeatPeriod: json['repeatPeriod'],
        time: json['time'],
        timeFrom: json['timeFrom'],
        timeTo: json['timeTo'],
        dayOfWeek: json['dayOfWeek'],
        messengerIcon: json['messengerIcon'],
        message: json['message'],
        img: json['img'],
        isActive: json['isActive'] == 1 ? true : false,
      );

  ReminderModel copyWith({
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
    return ReminderModel(
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

  factory ReminderModel.fromEntity(ReminderEntity entity) => ReminderModel(
      id: entity.id,
      notificationId: entity.notificationId,
      title: entity.title,
      repeatPeriod: entity.repeatPeriod,
      time: entity.time,
      timeFrom: entity.timeFrom,
      timeTo: entity.timeTo,
      dayOfWeek: entity.dayOfWeek,
      messengerIcon: entity.messengerIcon,
      message: entity.message,
      img: entity.img,
      isActive: entity.isActive);

  @override
  String toString() => 'ReminderModel('
      'id: $id, '
      'notificationId: $notificationId, '
      'title: $title, '
      'repeatPeriod: $repeatPeriod, '
      'time: $time,'
      'timeFrom: $timeFrom,'
      'timeTo: $timeTo,'
      'dayOfWeek: $dayOfWeek,'
      'messengerIcon: $messengerIcon, '
      'message: $message,'
      'img: $img,'
      'isActive: $isActive)';
}
