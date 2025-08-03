import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_five_zero/core/constants/app_colors.dart';
import 'package:four_five_zero/core/constants/app_property.dart';
import 'package:four_five_zero/core/constants/app_text.dart';
import 'package:four_five_zero/injection_container.dart';
import '../../core/constants/app_images.dart';
import '../../core/route/router.dart';
import '../../core/themes/app_theme.dart';
import '../block/reminder/reminder_bloc.dart';
import '../block/reminders_list/reminder_list_bloc.dart';
import 'package:four_five_zero/core/enum/reminder_enum.dart';
@RoutePage()
class CreateEditReminderScreen extends StatefulWidget {
  const CreateEditReminderScreen({super.key});

  @override
  State<CreateEditReminderScreen> createState() =>
      _CreateEditReminderScreenState();
}

class _CreateEditReminderScreenState extends State<CreateEditReminderScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> titleFormKey = GlobalKey<FormState>();
  final messageFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
    builder: (context, state) {
      _titleController.text = state.title;
      _messageController.text = state.message;
      return Scaffold(
            appBar: _buildAppBar(
              context,
              state.actionType == ReminderActionType.newReminder
                  ? AppText.createReminder
                  : AppText.editReminder,
            ),
            floatingActionButton: _buildFloatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                  Form(
                    key: titleFormKey,
                    child: _buildInputTextField(
                      ctx: context,
                      hintTitle: AppText.titleReminder,
                      textController: _titleController,
                      errorText: AppText.fieldCantBeEmpty,
                      onChanged: (value) => getIt<ReminderBloc>()
                          .add(ReminderTitleChangedEvent(value),
                      ),
                    ),
                  ),
                  const SizedBox(
                  height: 20,
                ),
                _buildSchedule(context),
                const SizedBox(
                  height: 20,
                ),
                _buildSelectedMessenger(context),
                const SizedBox(
                  height: 20,
                ),
                  Form(
                    key: messageFormKey,
                    child: _buildInputTextField(
                      ctx: context,
                      maxLine: 5,
                      hintTitle: AppText.message,
                      textController: _messageController,
                      errorText: AppText.fieldCantBeEmptyOr,
                      onChanged: (value) => getIt<ReminderBloc>()
                          .add(ReminderMessageChangedEvent(value),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                _buildPickImage(context),
              ],
            ),
          ),
        ),
      );
    },
    );
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        onPressed: () => getIt<AppRouter>().back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  _buildFloatingActionButton(BuildContext context) {

    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(

      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (titleFormKey.currentState!.validate() &&
                (state.img.isNotEmpty || messageFormKey.currentState!.validate())){
              getIt<ReminderBloc>().add(
                ReminderCreateUpdateEvent(
                  // title: _titleController.text,
                  // message: _messageController.text,
                ),
              );
              getIt<AppRouter>().back();
              getIt<ReminderListBloc>().add(ReminderListFetchEvent());
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            backgroundColor: AppColors.blueF3,
            foregroundColor: Colors.white,
            textStyle: Theme.of(context).textTheme.titleMedium,
            shape: RoundedRectangleBorder(
              borderRadius: AppProperty.allBorderRadiusLarge,
            ),
          ),
          child: const Text(AppText.save),
        );
      },
    );
  }

  TextFormField _buildInputTextField({
    required BuildContext ctx,
    bool isInputText = true,
    int? maxLine = 1,
    String? hintTitle,
    IconData? icon,
    String? label,
    required TextEditingController textController,
    required String errorText,
    void Function()? onTap,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      validator: (text) {
        if (text!.trim().isEmpty) {
          return errorText;
        } else {
          return null;
        }
      },
      onTap: isInputText ? null : onTap,
      onChanged: onChanged,
      maxLines: maxLine,
      readOnly: isInputText ? false : true,
      style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
            color: isInputText ? AppColors.whiteFF : AppColors.blueF3,
          ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: isInputText
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Icon(icon, color: AppColors.darkGrayBlue4E, size: 25),
              ),
        hintText: hintTitle,
      ),
     controller: textController,
    );
  }

  TextField _buildPickTextField({
    required BuildContext ctx,
    bool isInputText = true,
    int? maxLine = 1,
    String? hintTitle,
    IconData? icon,
    String? label,
    String? value,
    void Function()? onTap,
  }) {
    return TextField(
      onTap: isInputText ? null : onTap,
      onChanged: (value){
        context.read<ReminderBloc>().add(ReminderTitleChangedEvent(value));
      },
      maxLines: maxLine,
      readOnly: isInputText ? false : true,
      style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
            color: isInputText ? AppColors.whiteFF : AppColors.blueF3,
          ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: isInputText
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Icon(icon, color: AppColors.darkGrayBlue4E, size: 25),
              ),
        hintText: hintTitle,
      ),
      controller: TextEditingController(text: value),
    );
  }

//=================== SCHEDULE ======================================//
  BlocBuilder _buildSchedule(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
      builder: (context, state) {
        return Row(
          children: [
            _buildRepeatWidget(context),
            const SizedBox(width: 15),
            if (state.repeatPeriod == AppText.hourly) ...[
              _buildTimeWidget(
                state.timeFrom,
                AppText.timeFrom,
                () => showTimePickerDialog(
                  context,
                  (pickedTime) {
                    getIt<ReminderBloc>().add(
                      ReminderTimeFromPickedEvent(timeFrom: pickedTime),
                    );
                  },
                ),
              ),
              const SizedBox(width: 15),
              _buildTimeWidget(
                state.timeTo,
                AppText.timeTo,
                () => showTimePickerDialog(
                  context,
                  (pickedTime) {
                    getIt<ReminderBloc>().add(
                      ReminderTimeToPickedEvent(timeTo: pickedTime),
                    );
                  },
                ),
              )
            ] else if (state.repeatPeriod == AppText.daily) ...[
              _buildTimeWidget(
                state.time!,
                AppText.time,
                () => showTimePickerDialog(
                  context,
                  (pickedTime) {
                    getIt<ReminderBloc>().add(
                      ReminderTimePickedEvent(time: pickedTime),
                    );
                  },
                ),
              )
            ] else ...[
              _buildWeekdayPicker(context),
              const SizedBox(width: 15),
              _buildTimeWidget(
                state.time!,
                AppText.time,
                () => showTimePickerDialog(
                  context,
                  (pickedTime) {
                    getIt<ReminderBloc>().add(
                      ReminderTimePickedEvent(time: pickedTime),
                    );
                  },
                ),
              )
            ],

            //showWeekdayPicker
          ],
        );
      },
    );
  }

  BlocBuilder _buildRepeatWidget(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
      builder: (context, state) {
        return Expanded(
          child: PopupMenuButton<String>(
            color: AppColors.darkGrayBlue4E,
            shape: RoundedRectangleBorder(
              borderRadius: AppProperty.allBorderRadiusMedium,
            ),
            onSelected: (String result) {
              getIt<ReminderBloc>().add(
                ReminderPickRepeatPeriodEvent(repeatPeriod: result),
              );
            },
            itemBuilder: (BuildContext context) => [
              _buildPopupRepeatItem(ctx: context, title: AppText.hourly),
              _buildPopupRepeatItem(ctx: context, title: AppText.daily),
              _buildPopupRepeatItem(ctx: context, title: AppText.weekly),
            ],
            child: AbsorbPointer(
              child: _buildPickTextField(
                isInputText: false,
                ctx: context,
                icon: Icons.calendar_month_outlined,
                label: AppText.repeat,
                value: state.repeatPeriod,
                onTap: () {},
              ),
            ),
          ),
        );
      },
    );
  }

  PopupMenuItem<String> _buildPopupRepeatItem({
    required BuildContext ctx,
    required String title,
  }) {
    return PopupMenuItem<String>(
      value: title,
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.bodySmall,
      ),
    );
  }

  Future<void> showTimePickerDialog(
    BuildContext context,
    void Function(TimeOfDay pickedTime) onTimePicked,
  ) async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: AppTheme.darkAppTheme(context),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );
    if (pickedTime != null) {
      onTimePicked(pickedTime);
    }
  }

  BlocBuilder _buildWeekdayPicker(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
      builder: (context, state) {
        return Expanded(
          child: PopupMenuButton<int>(
            color: AppColors.darkGrayBlue4E,
            shape: RoundedRectangleBorder(
              borderRadius: AppProperty.allBorderRadiusMedium,
            ),
            onSelected: (int result) {
              getIt<ReminderBloc>().add(
                ReminderPickDayOfWeekEvent(day: result),
              );
            },
            itemBuilder: (BuildContext context) => [
              for (var i = 0; i < AppText.weekdays.length; i++)
                PopupMenuItem<int>(
                  value: i,
                  child: Text(
                    AppText.weekdays[i],
                    style: const TextStyle(
                        color: AppColors.whiteFF),
                  ),
                ),
            ],
            child: AbsorbPointer(
              child: _buildPickTextField(
                isInputText: false,
                ctx: context,
                icon: Icons.calendar_view_day,
                label: AppText.dayOfWeek,
                value: AppText.weekdays[state.dayOfWeek],
                onTap: () {},
              ),
            ),
          ),
        );
      },
    );
  }

  _buildTimeWidget(
    String time,
    String label,
    Future<void> Function() onTap,
  ) {
    return Expanded(
      child: _buildPickTextField(
        isInputText: false,
        ctx: context,
        icon: Icons.access_time,
        label: label,
        value: time,
        onTap: () => onTap(),
      ),
    );
  }

// ========================= Attache Messenger =====================//
  BlocBuilder _buildSelectedMessenger(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppText.chooseMessenger,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            PopupMenuButton(
              color: AppColors.darkGrayBlue4E,
              shape: RoundedRectangleBorder(
                borderRadius: AppProperty.allBorderRadiusMedium,
              ),
              onSelected: (int result) {
                getIt<ReminderBloc>().add(
                  ReminderSelectedLogoMessengerEvent(indexMessenger: result),
                );
              },
              itemBuilder: (BuildContext context) => [
                for (int i = 0; i < AppImages.logoMessengers.length; i++)
                  _buildPopupMessengerItem(
                    ctx: context,
                    name: AppText.messengersName[i],
                    img: AppImages.logoMessengers[i],
                    val: i,
                  ),
              ],
              child: Image.asset(
                AppImages.logoMessengers[state.messengerIcon],
                width: 40,
                height: 40,
              ),
            ),
          ],
        );
      },
    );
  }

  PopupMenuItem<int> _buildPopupMessengerItem(
      {required BuildContext ctx,
      required String name,
      required String img,
      required int val}) {
    return PopupMenuItem<int>(
      value: val,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            img,
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: Theme.of(ctx).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

// ============================== Attache Image =====================//

  BlocBuilder _buildPickImage(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppText.attachImage,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            IconButton(
              onPressed: () async {
                getIt<ReminderBloc>().add(ReminderPickImageFromGallery());
                // await pickImageFromGallery();
              },
              icon: state.img.isEmpty
                  ? const Icon(
                      Icons.attach_file,
                      color: AppColors.darkGrayBlue4E,
                      size: 40.0,
                    )
                  : SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(
                            File(state.img),
                            fit: BoxFit.cover,
                          )),
                    ),
            )
          ],
        );
      },
    );
  }
}
