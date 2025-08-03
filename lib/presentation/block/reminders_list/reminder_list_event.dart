part of 'reminder_list_bloc.dart';

@immutable
sealed class ReminderListEvent extends Equatable {}

final class ReminderListFetchEvent extends ReminderListEvent {
  @override
  List<Object?> get props => [];
}

final class ReminderListUpdateEvent extends ReminderListEvent {
  ReminderListUpdateEvent(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ReminderListDeleteEvent extends ReminderListEvent {
  ReminderListDeleteEvent(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
