part of 'reminder_list_bloc.dart';

@immutable
sealed class ReminderListState extends Equatable {}

final class ReminderListLoadingState extends ReminderListState {
  @override
  List<Object?> get props => [];
}

final class ReminderListSuccessState extends ReminderListState {
  ReminderListSuccessState(this.reminderList);

  final List<ReminderEntity> reminderList;

  @override
  List<Object?> get props => [reminderList];
}

final class ReminderListErrorState extends ReminderListState {
  ReminderListErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
