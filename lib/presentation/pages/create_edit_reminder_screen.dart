import 'package:flutter/material.dart';
import 'package:four_five_zero/core/constants/app_colors.dart';
import 'package:four_five_zero/core/constants/app_property.dart';
import 'package:four_five_zero/core/constants/app_text.dart';

import '../../core/constants/app_images.dart';

class CreateEditReminderScreen extends StatelessWidget {
  const CreateEditReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              const SizedBox(
                height: 20,
              ),
              _buildAttacheMessenger(context),
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
              _buildAttacheImage(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildAttacheImage(BuildContext context) {
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

  Row _buildAttacheMessenger(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppText.chooseMessenger,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Image.asset(
          AppImages.logoWhatsApp,
          width: 40,
          height: 40,
        ),
      ],
    );
  }

  TextField _buildTextField({
    required BuildContext ctx,
    int maxLine = 1,
    required String hintTitle,
  }) {
    return TextField(
      maxLines: maxLine,
      style: Theme.of(ctx).textTheme.titleSmall,
      decoration: InputDecoration(
        hintText: hintTitle,
      ),
    );
  }
}
