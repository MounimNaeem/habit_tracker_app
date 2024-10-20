import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker_app/common_widgets/custom_button_widget.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';

class CustomDeleteDialog extends StatelessWidget {
  final Function() onTap;

  const CustomDeleteDialog({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ),
                // 10.verticalSpace,
                Divider(
                  color: textColor.withOpacity(0.2),
                ),
                22.verticalSpace,
                Image.asset(
                  'assets/delete_icon.png',
                  width: 40.w,
                ),
                26.verticalSpace,
                Text(
                  'Are you sure want to delete?',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: textColor),
                ),
                22.verticalSpace,
                CustomButtonWidget(
                  onTap: () => onTap(),
                  btnText: 'Delete',
                ),
                22.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
