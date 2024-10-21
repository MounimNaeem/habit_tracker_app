import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TopProgressCard extends StatelessWidget {
  final int completedHabits;
  final int totalHabits;

  const TopProgressCard({
    required this.completedHabits,
    required this.totalHabits,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double percentage =
        (totalHabits == 0) ? 0 : (completedHabits / totalHabits) * 100;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 200.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
            image: AssetImage('assets/card_background_img.png'),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          26.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularPercentIndicator(
                  radius: 54.0,
                  lineWidth: 10.0.r,
                  animation: true,
                  percent:
                      (totalHabits == 0) ? 0 : (completedHabits / totalHabits),
                  center: Text(
                    "${percentage.toStringAsFixed(0)}%",
                    style: textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.6),
                  progressColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                29.horizontalSpace,
                Text(
                  '$completedHabits of $totalHabits habits\ncompleted today!',
                  style: textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 8.0.w),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/calendar_flatline.png')),
          ),
        ],
      ),
    );
  }
}
