import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:four_five_zero/core/enum/reminder_enum.dart';
import 'package:four_five_zero/core/request_result/request_result.dart';
import 'package:four_five_zero/domain/entities/reminder_entity.dart';
import 'package:four_five_zero/domain/usecase/create_reminder_usercase.dart';

import '../../../core/constants/app_defaults.dart';
import '../../../core/constants/app_text.dart';

import '../../../core/services/id_generator.dart';
import '../../../core/usecase/no_params.dart';
import '../../../domain/usecase/fetch_reminders_usercase.dart';
import '../../../domain/usecase/pick_img_usecase.dart';
import '../../../domain/usecase/update_reminder_usercase.dart';
import '../../utils/time_utils.dart';

part 'reminder_event.dart';

part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderCreateEditState> {
  ReminderBloc(
      this.pickImageUseCase,
      this.createReminderUserCase,
      this.fetchRemindersUserCase,
      this.updateReminderUserCase,
      this.idGeneratorService)
      : super(const ReminderCreateEditState()) {
    on<ReminderInitialEvent>(_onInitReminder);
    on<ReminderPickRepeatPeriodEvent>(_onPickRepeatPeriod);
    on<ReminderPickDayOfWeekEvent>(_onPickDayOfWeek);
    on<ReminderTimePickedEvent>(_onTimePicked);
    on<ReminderTimeFromPickedEvent>(_onTimeFromPicked);
    on<ReminderTimeToPickedEvent>(_onTimeToPicked);
    on<ReminderSelectedLogoMessengerEvent>(_onPickLogoMessenger);
    on<ReminderPickImageFromGallery>(_onPickImageFromGallery);
    on<ReminderCreateUpdateEvent>(_createUpdateReminder);
    on<SetReminderActiveEvent>(_setReminderActive);
    on<ReminderTitleChangedEvent>(_onTitleChanged);
    on<ReminderMessageChangedEvent>(_onMessageChanged);
  }

  final PickImageUseCase pickImageUseCase;
  final CreateReminderUserCase createReminderUserCase;
  final FetchRemindersUserCase fetchRemindersUserCase;
  final UpdateReminderUserCase updateReminderUserCase;
  final IdGeneratorService idGeneratorService;

  void _onInitReminder(
      ReminderInitialEvent event, Emitter<ReminderCreateEditState> emit) {
    if (event.actionType == ReminderActionType.newReminder) {
      emit(const ReminderCreateEditState());
    } else if (event.actionType == ReminderActionType.editReminder) {
      emit(ReminderCreateEditState.fromReminder(event.reminder!));
    }
  }

  void _onTitleChanged(
      ReminderTitleChangedEvent event, Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onPickRepeatPeriod(ReminderPickRepeatPeriodEvent event,
      Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(repeatPeriod: event.repeatPeriod));
  }

  void _onPickDayOfWeek(
      ReminderPickDayOfWeekEvent event, Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(dayOfWeek: event.day));
  }

  Future<void> _onTimePicked(ReminderTimePickedEvent event,
      Emitter<ReminderCreateEditState> emit) async {
    emit(state.copyWith(time: formatTime(event.time)));
  }

  void _onTimeFromPicked(ReminderTimeFromPickedEvent event,
      Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(timeFrom: formatTime(event.timeFrom)));
  }

  void _onTimeToPicked(
      ReminderTimeToPickedEvent event, Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(timeTo: formatTime(event.timeTo)));
  }

  void _onPickLogoMessenger(ReminderSelectedLogoMessengerEvent event,
      Emitter<ReminderCreateEditState> emit) {
    emit(
      state.copyWith(messengerIcon: event.indexMessenger),
    );
  }

  void _onMessageChanged(ReminderMessageChangedEvent event,
      Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(message: event.message));
  }

  Future<void> _onPickImageFromGallery(ReminderPickImageFromGallery event,
      Emitter<ReminderCreateEditState> emit) async {
    final img = await pickImageUseCase.call(params: NoParams());
    emit(state.copyWith(img: img));
  }

  void _setReminderActive(
      SetReminderActiveEvent event, Emitter<ReminderCreateEditState> emit) {
    emit(state.copyWith(isActive: event.isActive));
    add(ReminderCreateUpdateEvent());
  }

  Future<void> _createUpdateReminder(ReminderCreateUpdateEvent event,
      Emitter<ReminderCreateEditState> emit) async {
    final reminder = _buildReminderEntity();

    final result = state.actionType == ReminderActionType.newReminder
        ? await createReminderUserCase.call(params: reminder)
        : await updateReminderUserCase.call(params: reminder);

    if (result is RequestSuccess) {
      debugPrint('Все збереглось');
    } else if (result is RequestError) {
      debugPrint('Помилка: ${result.errorMessage}');
    }
  }

  ReminderEntity _buildReminderEntity() {
    final base = state.toReminderEntity();
    final isNewActionType = state.actionType == ReminderActionType.newReminder;
    final id = isNewActionType ? idGeneratorService.generateUuid() : base.id;
    final notifId = isNewActionType
        ? idGeneratorService.generateNotificationId()
        : base.notificationId;
    return base.copyWith(
      id: id,
      notificationId: notifId,
    );
  }
}
