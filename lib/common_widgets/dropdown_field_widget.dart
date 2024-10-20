import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';

class DropdownFieldWidget extends StatefulWidget {
  final List<DropDownValueModel> items;
  final SingleValueDropDownController cnt;

  final Function(dynamic)? onChange;

  const DropdownFieldWidget({
    super.key,
    required this.items,
    required this.cnt,
    this.hintText,
    this.value,
    this.onChange,
    this.validator,
  });

  final String? hintText;
  final dynamic value;
  final String? Function(dynamic)? validator;

  @override
  State<DropdownFieldWidget> createState() => _DropdownFieldWidgetState();
}

class _DropdownFieldWidgetState extends State<DropdownFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      controller: widget.cnt,
      clearOption: false,
      textStyle: Theme.of(context).textTheme.titleMedium,
      textFieldDecoration: InputDecoration(
        hintText: widget.hintText ?? '',
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: shadowColor),
        focusedBorder: inputFocusBorder(color: inputFieldBorderColor),
        focusedErrorBorder: inputFocusBorder(color: Colors.red),
        border: inputFocusBorder(color: inputFieldBorderColor),
        enabledBorder: inputFocusBorder(color: inputFieldBorderColor),
        errorBorder: inputFocusBorder(color: Colors.red),
        disabledBorder: inputFocusBorder(color: inputFieldBorderColor),
      ),
      validator: widget.validator,
      dropDownItemCount: widget.items.length,
      dropDownList: widget.items,
      onChanged: widget.onChange,
    );
  }

  inputFocusBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color ?? Theme.of(context).primaryColor.withOpacity(0.5),
          width: 2.0,
        ));
  }
}
