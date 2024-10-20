import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFieldLabel extends StatelessWidget {
  final String text;

  const InputFieldLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, bottom: 5.h),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              height: 1.21,
            ),
      ),
    );
  }
}
