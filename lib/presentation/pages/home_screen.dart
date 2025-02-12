import 'package:flutter/material.dart';
import 'package:four_five_zero/core/constants/app_text.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_property.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: AppProperty.paddingTopBottomSmall,
          child: Image.asset(AppImages.logo28Ombr),
        ),
        titleSpacing: 5,
        title: Text(
          AppText.appName,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.yellow07),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blueF3,
        child: const Icon(
          Icons.add,
          color: AppColors.whiteFF,
          size: 24.0,
        ),
        onPressed: () {},
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (ctx, index) {
          return _buildReminderItem(context);
        },
      ),
    );
  }

  Card _buildReminderItem(BuildContext ctx) {
    return Card(
      child: InkWell(
        borderRadius: AppProperty.allBorderRadiusLarge,
        splashColor: AppColors.darkGrayBlue29.withOpacity(0.3),
        highlightColor: AppColors.darkGrayBlue29.withOpacity(0.1),
        onTap: () {},
        child: Padding(
          padding: AppProperty.allPaddingSmall,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(width: 30, height: 30, AppImages.logoWhatsApp),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        activeTrackColor: AppColors.blueF3,
                        value: true,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
                Text(
                  'Повідомлення в РВК 93/4/3',
                  style: Theme.of(ctx).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Гора 5.1.0',
                  style: Theme.of(ctx).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    PopupMenuButton(
                      color: AppColors.darkGrayBlue4E,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppProperty.allBorderRadiusMedium,
                      ),
                      onSelected: (String result) {
                        print('Вибрано: $result');
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text(
                            AppText.delete,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text(
                            AppText.edit,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
