import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomColorPickerWidget extends StatelessWidget {
  final List<Color> colorsList;
  final Function(Color color) onTap;

  const CustomColorPickerWidget({
    super.key,
    required this.colorsList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0.h, left: 15.w),
          child: Text(
            'Select Habit Color',
            style: textTheme.bodyLarge,
          ),
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // number of items in each row
              mainAxisSpacing: 32.0.w, // spacing between rows
              crossAxisSpacing: 16.0.h, // spacing between columns
              childAspectRatio: 10 / 10),
          shrinkWrap: true,
          itemCount: colorsList.length,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                onTap(colorsList[index]);
                Navigator.pop(context);
              },
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorsList[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}
