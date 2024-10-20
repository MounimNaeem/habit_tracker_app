import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker_app/screens/add_habit/view/add_habit_view.dart';
import 'package:habit_tracker_app/screens/home/widgets/list_tile_widget.dart';
import 'package:habit_tracker_app/screens/home/widgets/top_progress_card.dart';
import 'package:habit_tracker_app/src/app/global_variables/global_variables.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(habitProvider).providerInit();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(habitProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          59.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEE, d MMMM yyyy').format(DateTime.now()),
                  style: textTheme.bodyLarge,
                ),
                5.verticalSpace,
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Hello, ', style: textTheme.displayLarge),
                      TextSpan(
                          text: 'John!',
                          style: textTheme.displayLarge!
                              .copyWith(color: Theme.of(context).primaryColor))
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,

          /// Custom widget
          TopProgressCard(
            completedHabits: notifier.completeHabit,
            totalHabits: notifier.habitList.length,
          ),
          22.verticalSpace,

          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 22.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 1),
                      color: shadowColor.withOpacity(0.15),
                      blurRadius: 14,
                      spreadRadius: 6,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today Habit',
                    style: textTheme.displayMedium,
                  ),
                  16.verticalSpace,
                  Expanded(
                    child: (notifier.habitList.isEmpty)
                        ? const Center(
                            child: Text('You\'ve not created any habits'),
                          )

                        /// Habit list widget
                        : ListView.separated(
                            itemCount: notifier.habitList.length,
                            padding: const EdgeInsets.only(top: 0, bottom: 15),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final habit = notifier.habitList[index];
                              return Row(
                                children: [
                                  /// widget for marking habit completed
                                  Padding(
                                    padding: EdgeInsets.all(3.h),
                                    child: GestureDetector(
                                      onTap: () =>
                                          notifier.markHabitCompleted(index),
                                      child: Icon(
                                        (!habit.isCompleted)
                                            ? Icons.circle_outlined
                                            : Icons.check_circle,
                                        color: (habit.isCompleted)
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.6)
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.3),
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace,

                                  /// main list tile for displaying habit name and category
                                  ListTileWidget(
                                    index: index,
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                17.verticalSpace,
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),

      /// floatingActionButton for adding new habit
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddHabitView(
                  appBarTitle: 'Add New Habit',
                  isAddNewHabit: true,
                ),
              ));
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 40,
        ),
      ),
    );
  }
}
