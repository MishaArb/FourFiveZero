part of 'reminder_bloc.dart';

final class ReminderCreateEditState extends Equatable {
  const ReminderCreateEditState({
    this.id = '',
    this.notificationId = 0,
    this.title = '',
    this.repeatPeriod = AppText.daily,
    this.time = '08:00',
    this.timeFrom = AppDefaults.defaultTimeFrom,
    this.timeTo =  AppDefaults.defaultTimeTo,
    this.dayOfWeek = 0,
    this.messengerIcon = AppDefaults.defaultMessengerIcon,
    this.message = '',
    this.img = '',
    this.isActive = true,
    this.actionType = ReminderActionType.newReminder,

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
  final ReminderActionType actionType;


  factory ReminderCreateEditState.fromReminder(ReminderEntity reminder) {
    return ReminderCreateEditState(
      id: reminder.id,
      notificationId: reminder.notificationId,
      title: reminder.title,
      repeatPeriod: reminder.repeatPeriod,
      time: reminder.time,
      timeFrom: reminder.timeFrom,
      timeTo: reminder.timeTo,
      dayOfWeek: reminder.dayOfWeek,
      messengerIcon: reminder.messengerIcon,
      message: reminder.message,
      img: reminder.img,
      isActive: reminder.isActive,
      actionType: ReminderActionType.editReminder,
    );
  }

  ReminderEntity toReminderEntity() {
    return ReminderEntity(
      id: id ,
      notificationId: notificationId ,
      title: title,
      repeatPeriod: repeatPeriod,
      time: time,
      timeFrom: timeFrom,
      timeTo: timeTo,
      dayOfWeek: dayOfWeek,
      messengerIcon: messengerIcon,
      message: message,
      img: img,
      isActive: isActive,
    );
  }
    ReminderCreateEditState copyWith({
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
    ReminderActionType? actionType,
  }) {
    return ReminderCreateEditState(
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
      actionType: actionType ?? this.actionType,
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
    actionType
  ];
}


