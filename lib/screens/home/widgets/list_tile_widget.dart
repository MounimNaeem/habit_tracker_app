import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker_app/screens/add_habit/view/add_habit_view.dart';
import 'package:habit_tracker_app/src/app/global_variables/global_variables.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';

class ListTileWidget extends ConsumerWidget {
  final int index;

  const ListTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(habitProvider);
    final habit = notifier.habitList[index];
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddHabitView(
                appBarTitle: notifier.habitList[index].habitName,
                isAddNewHabit: false,
                habitIndex: index,
              ),
            ),
          );
        },
        child: Container(
          height: 68.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
          decoration: BoxDecoration(
              color: (habit.isCompleted)
                  ? finishedHabitColor
                  : habit.habitColor ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              5.horizontalSpace,
              Icon(habit.habitIcon ?? Icons.tag_faces,
                  color: (habit.isCompleted)
                      ? Theme.of(context).primaryColor.withOpacity(0.6)
                      : Theme.of(context).scaffoldBackgroundColor),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.6.sw,
                    child: Text(
                      habit.habitName,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.ellipsis,
                          height: 1,
                          color: (habit.isCompleted)
                              ? Theme.of(context).primaryColor.withOpacity(0.6)
                              : Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  2.verticalSpace,
                  Row(
                    children: [
                      Text('Category: ',
                          style: textTheme.titleSmall!.copyWith(
                              color: (habit.isCompleted)
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6)
                                  : Theme.of(context).scaffoldBackgroundColor)),
                      Text(habit.category,
                          style: textTheme.titleMedium!.copyWith(
                              color: (habit.isCompleted)
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6)
                                  : Theme.of(context).scaffoldBackgroundColor)),
                      // const Spacer(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
