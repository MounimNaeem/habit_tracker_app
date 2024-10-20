import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatefulWidget {
  final String? btnText;
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Function()? onTap;
  final TextStyle? textStyle;
  final double? radius;
  final Color? bgColor;

  const CustomButtonWidget(
      {super.key,
      this.bgColor,
      this.radius,
      this.height,
      this.width,
      this.btnText,
      this.onTap,
      this.horizontalPadding,
      this.verticalPadding,
      this.textStyle});

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  void handleButtonTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 200.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(widget.radius ?? 10),
      ),
      child: TextButton(
        onPressed: handleButtonTap,
        style: TextButton.styleFrom().copyWith(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: (widget.horizontalPadding != null)
                  ? widget.horizontalPadding!
                  : 0,
              vertical: (widget.verticalPadding != null)
                  ? widget.verticalPadding!
                  : 15.h,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
              (widget.bgColor ?? Theme.of(context).primaryColor)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 10),
            ),
          ),
        ),
        child: Text(widget.btnText!,
            style: widget.textStyle ??
                Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor)),
      ),
    );
  }
}
