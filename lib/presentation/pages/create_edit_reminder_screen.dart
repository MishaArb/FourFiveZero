import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:four_five_zero/core/constants/app_colors.dart';
import 'package:four_five_zero/core/constants/app_property.dart';
import 'package:four_five_zero/core/constants/app_text.dart';
import '../../core/constants/app_images.dart';
import '../../core/themes/app_theme.dart';

@RoutePage()
class CreateEditReminderScreen extends StatelessWidget {
  const CreateEditReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => AutoRouter.of(context).back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppText.createEditReminder,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(
                ctx: context,
                hintTitle: AppText.titleReminder,
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
              _buildTextField(
                ctx: context,
                maxLine: 5,
                hintTitle: AppText.message,
              ),
              const SizedBox(
                height: 20,
              ),
              _buildSelectedImage(context),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({
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
  Row _buildSchedule(BuildContext context) {
    return Row(
      children: [
        _buildRepeatWidget(context),
        const SizedBox(width: 15),
        _buildTimeWidget(context),
      ],
    );
  }

  Expanded _buildRepeatWidget(BuildContext context) {
    return Expanded(
      child: PopupMenuButton<String>(
        color: AppColors.darkGrayBlue4E,
        shape: RoundedRectangleBorder(
          borderRadius: AppProperty.allBorderRadiusMedium,
        ),
        onSelected: (String result) {
          print('Вибрано: $result');
        },
        itemBuilder: (BuildContext context) => [
          _buildPopupRepeatItem(ctx: context, title: AppText.hourly),
          _buildPopupRepeatItem(ctx: context, title: AppText.daily),
          _buildPopupRepeatItem(ctx: context, title: AppText.weekly),
        ],
        child: AbsorbPointer(
          child: _buildTextField(
            isInputText: false,
            ctx: context,
            icon: Icons.calendar_month_outlined,
            label: AppText.repeat,
            value: AppText.hourly,
            onTap: () {},
          ),
        ),
      ),
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

  Expanded _buildTimeWidget(BuildContext context) {
    return Expanded(
      child: _buildTextField(
          isInputText: false,
          ctx: context,
          icon: Icons.access_time,
          label: AppText.time,
          value: '10:25',
          onTap: () async {
            await _selectedTime24Hour(context);
          }),
    );
  }

  Future<TimeOfDay?> _selectedTime24Hour(BuildContext cxt) async {
    return await showTimePicker(
      context: cxt,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
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
  }

// ========================= Attache Messenger =====================//
  Row _buildSelectedMessenger(BuildContext context) {
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
          onSelected: (String result) {
            print('Вибрано: $result');
          },
          itemBuilder: (BuildContext context) => [
            _buildPopupMessengerItem(
              ctx: context,
              name: AppText.whatsApp,
              img: AppImages.logoMessengers[0],
            ),
            _buildPopupMessengerItem(
              ctx: context,
              name: AppText.signal,
              img: AppImages.logoMessengers[1],
            ),
            _buildPopupMessengerItem(
              ctx: context,
              name: AppText.telegram,
              img: AppImages.logoMessengers[2],
            ),
          ],
          child: Image.asset(
            AppImages.logoMessengers[0],
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMessengerItem({
    required BuildContext ctx,
    required String name,
    required String img,
  }) {
    return PopupMenuItem<String>(
      value: name,
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
  Row _buildSelectedImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppText.attachImage,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Icon(
          Icons.attach_file,
          color: AppColors.darkGrayBlue4E,
          size: 40.0,
        )
      ],
    );
  }
}
