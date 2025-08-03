import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_five_zero/core/constants/app_text.dart';
import 'package:four_five_zero/core/enum/reminder_enum.dart';
import 'package:four_five_zero/domain/entities/reminder_entity.dart';
import 'package:four_five_zero/injection_container.dart';
import 'package:four_five_zero/presentation/block/reminders_list/reminder_list_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_property.dart';
import '../../core/route/router.dart';
import '../block/reminder/reminder_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListBloc, ReminderListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          floatingActionButton: _buildFloatingActionButton(context),
          body: () {
            if (state is ReminderListSuccessState) {
              if(state.reminderList.isNotEmpty) {
               return ListView.builder(
                  itemCount: state.reminderList.length,
                  itemBuilder: (ctx, index) {
                    return _buildReminderItem(
                      ctx: context,
                      id: state.reminderList[index].id,
                      logoMessengers: AppImages.logoMessengers[
                      state.reminderList[index].messengerIcon],
                      title: state.reminderList[index].title,
                      message: state.reminderList[index].message,
                      isActive: state.reminderList[index].isActive,
                      onTap: () async {
                        getIt<ReminderBloc>().add(
                          ReminderInitialEvent(
                              actionType: ReminderActionType.editReminder,
                              reminder: state.reminderList[index],
                          ),
                        );

                        getIt<AppRouter>()
                            .pushNamed('/createEditReminderScreen');
                      },
                      reminder: state.reminderList[index],
                        onChanged: (bool value)  {
                          getIt<ReminderBloc>().add(
                            ReminderInitialEvent(
                              actionType: ReminderActionType.editReminder,
                              reminder: state.reminderList[index],
                            ),
                          );
                          getIt<ReminderBloc>().add(SetReminderActiveEvent(value));
                          getIt<ReminderListBloc>().add(ReminderListFetchEvent());
                        }

                    );
                  },
                ) ;
              } else {
                return Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    AppText.createReminderByPress,
                    style: Theme.of(context)
                        .textTheme.titleSmall
                        ?.copyWith(color: AppColors.whiteFF),
                  ),
                );
              }
            } else if (state is ReminderListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReminderListErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          }(),
        );
      },
    );
  }

  //AppImages.logoMessengers[0]

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  BlocBuilder<dynamic, dynamic> _buildFloatingActionButton(BuildContext ctx) {
    return BlocBuilder<ReminderBloc, ReminderCreateEditState>(
      builder: (context, state) {
        return FloatingActionButton(
          backgroundColor: AppColors.blueF3,
          child: const Icon(
            Icons.add,
            color: AppColors.whiteFF,
            size: 24.0,
          ),
          onPressed: () {
            getIt<AppRouter>().pushNamed('/createEditReminderScreen');
            getIt<ReminderBloc>().add(ReminderInitialEvent(actionType: ReminderActionType.newReminder));
          },
        );
      },
    );
  }

  Card _buildReminderItem({
      required BuildContext ctx,
      required ReminderEntity reminder,
      required String id,
      required String logoMessengers,
      required String title,
      required String message,
      required bool isActive,
      required void Function() onTap,
      required void Function(bool value) onChanged
  }) {
    return Card(
      child: InkWell(
        borderRadius: AppProperty.allBorderRadiusLarge,
        splashColor: AppColors.darkGrayBlue29.withOpacity(0.3),
        highlightColor: AppColors.darkGrayBlue29.withOpacity(0.1),
        onTap: () => onTap(),
        child: Padding(
          padding: AppProperty.allPaddingSmall,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        width: 30, height: 30, logoMessengers),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        activeTrackColor: AppColors.blueF3,
                        value: isActive,
                        onChanged: (value)=> onChanged(value),
                      ),
                    )
                  ],
                ),
                Text(
                  title,
                  style: Theme.of(ctx).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  message,
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
                        debugPrint('Вибрано: $result');
                        switch (result) {
                          case AppText.delete:
                            getIt<ReminderListBloc>().add(ReminderListDeleteEvent(id));
                            break;
                          case AppText.edit:
                          print('Редагувати');
                          getIt<ReminderBloc>().add(
                            ReminderInitialEvent(
                                actionType: ReminderActionType.editReminder,
                                reminder: reminder),
                          );

                          getIt<AppRouter>()
                              .pushNamed('/createEditReminderScreen');
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: AppText.delete,
                          child: Text(
                            AppText.delete,
                            style: Theme.of(ctx).textTheme.bodySmall,
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: AppText.edit,
                          child: Text(
                            AppText.edit,
                            style: Theme.of(ctx).textTheme.bodySmall,
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
