import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:four_five_zero/core/request_result/request_result.dart';
import 'package:four_five_zero/domain/entities/reminder_entity.dart';
import 'package:four_five_zero/domain/usecase/delete_reminder_usercase.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecase/fetch_reminders_usercase.dart';

part 'reminder_list_event.dart';

part 'reminder_list_state.dart';

class ReminderListBloc extends Bloc<ReminderListEvent, ReminderListState> {
  ReminderListBloc(this.fetchRemindersUserCase, this.deleteReminderUserCase)
      : super(ReminderListLoadingState()) {
    on<ReminderListFetchEvent>(_onFetchReminders);
    on<ReminderListDeleteEvent>(_onDeleteReminder);
  }

  final FetchRemindersUserCase fetchRemindersUserCase;
  final DeleteReminderUserCase deleteReminderUserCase;

  _onFetchReminders(
      ReminderListFetchEvent event, Emitter<ReminderListState> emit) async {
    final requestResult = await fetchRemindersUserCase();
    if (requestResult is RequestSuccess) {
      emit(ReminderListSuccessState(requestResult.data!));
    } else if (requestResult is RequestError) {
      emit(ReminderListErrorState(requestResult.errorMessage!));
    }
  }

  _onDeleteReminder(
      ReminderListDeleteEvent event, Emitter<ReminderListState> emit)async {
   await deleteReminderUserCase.call(params: event.id);
   add(ReminderListFetchEvent());
  }
}
