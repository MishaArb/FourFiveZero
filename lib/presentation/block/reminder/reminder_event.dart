part of 'reminder_bloc.dart';

@immutable
abstract class ReminderEvent extends Equatable {}

class ReminderInitialEvent extends ReminderEvent {
  ReminderInitialEvent({required this.actionType, this.reminder});

  final ReminderActionType actionType;
  final ReminderEntity? reminder;

  @override
  List<Object?> get props => [actionType];
}

class ReminderTitleChangedEvent extends ReminderEvent {
  final String title;

  ReminderTitleChangedEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class ReminderPickRepeatPeriodEvent extends ReminderEvent {
  ReminderPickRepeatPeriodEvent({required this.repeatPeriod});

  final String repeatPeriod;

  @override
  List<Object?> get props => [repeatPeriod];
}

class ReminderPickDayOfWeekEvent extends ReminderEvent {
  ReminderPickDayOfWeekEvent({required this.day});

  final int day;

  @override
  List<Object?> get props => [day];
}

class ReminderTimePickedEvent extends ReminderEvent {
  ReminderTimePickedEvent({required this.time});

  final TimeOfDay time;

  @override
  List<Object?> get props => [time];
}

class ReminderTimeFromPickedEvent extends ReminderEvent {
  ReminderTimeFromPickedEvent({required this.timeFrom});

  final TimeOfDay timeFrom;

  @override
  List<Object?> get props => [timeFrom];
}

class ReminderTimeToPickedEvent extends ReminderEvent {
  ReminderTimeToPickedEvent({required this.timeTo});

  final TimeOfDay timeTo;

  @override
  List<Object?> get props => [timeTo];
}

class ReminderMessageChangedEvent extends ReminderEvent {
  final String message;

  ReminderMessageChangedEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class ReminderSelectedLogoMessengerEvent extends ReminderEvent {
  ReminderSelectedLogoMessengerEvent({required this.indexMessenger});

  final int indexMessenger;

  @override
  List<Object?> get props => [indexMessenger];
}

class ReminderPickImageFromGallery extends ReminderEvent {
  ReminderPickImageFromGallery();

  @override
  List<Object?> get props => [];
}

class SetReminderActiveEvent extends ReminderEvent {
  SetReminderActiveEvent(this.isActive);

  final bool isActive;

  @override
  List<Object?> get props => [];
}

class ReminderCreateUpdateEvent extends ReminderEvent {
  ReminderCreateUpdateEvent();

  @override
  List<Object?> get props => [];
}
