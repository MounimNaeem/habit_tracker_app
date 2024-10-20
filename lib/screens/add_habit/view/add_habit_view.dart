import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker_app/common_widgets/custom_button_widget.dart';
import 'package:habit_tracker_app/common_widgets/custom_color_picker_widget.dart';
import 'package:habit_tracker_app/common_widgets/dropdown_field_widget.dart';
import 'package:habit_tracker_app/common_widgets/input_field_widget.dart';
import 'package:habit_tracker_app/common_widgets/inputfield_label_widget.dart';
import 'package:habit_tracker_app/screens/add_habit/widgets/custom_delete_dialog.dart';
import 'package:habit_tracker_app/src/app/global_variables/global_variables.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';

class AddHabitView extends ConsumerStatefulWidget {
  final bool isAddNewHabit;
  final String appBarTitle;
  final int? habitIndex;

  const AddHabitView(
      {super.key,
      required this.appBarTitle,
      required this.isAddNewHabit,
      this.habitIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHabitViewState();
}

class _AddHabitViewState extends ConsumerState<AddHabitView> {
  @override
  void initState() {
    if (!widget.isAddNewHabit) {
      ref
          .read(habitProvider)
          .addNewHabitScreenInit(index: widget.habitIndex ?? -1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(habitProvider);
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text((!widget.isAddNewHabit && !notifier.isEdit)
            ? 'Edit ${widget.appBarTitle}'
            : widget.appBarTitle),
        leading: IconButton(
          onPressed: () {
            notifier.disposeAddHabitViewController();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),

        /// show edit icon in app bar for editing habit
        actions: (widget.isAddNewHabit)
            ? []
            : [
                IconButton(
                  onPressed: () => notifier.onTapEditIcon(),
                  icon: const Icon(Icons.edit),
                ),
              ],
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        shape: Border(
            bottom: BorderSide(
          color: textColor.withOpacity(0.2),
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              /// IgnorePointer active when user just want to see habit in detail
              IgnorePointer(
                ignoring: notifier.isEdit,

                /// Form widget
                child: Form(
                  key: notifier.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      22.verticalSpace,

                      /// Habit Name field
                      const InputFieldLabel(text: 'Habit Name'),
                      InputField(
                        controller: notifier.habitNameCntlr,
                        isDecorationEnable: true,
                        hint: 'Enter Habit Name',
                        validator: (value) => notifier.habitNameValidator(
                            value: value, msg: 'Habit Name is required'),
                      ),
                      20.verticalSpace,

                      /// Category Dropdown
                      const InputFieldLabel(text: 'Category'),
                      DropdownFieldWidget(
                        items: notifier.categories,
                        cnt: notifier.categoryCntlr,
                        hintText: 'Select Habit Category',
                        validator: (value) => notifier.habitNameValidator(
                            value: value, msg: 'Select Category'),
                      ),
                      20.verticalSpace,

                      /// Repeat Dropdown
                      const InputFieldLabel(text: 'Repeat'),
                      DropdownFieldWidget(
                          items: notifier.repeat,
                          cnt: notifier.repeatCntlr,
                          hintText: 'Select Habit frequency',
                          validator: (value) => notifier.habitNameValidator(
                              value: value, msg: 'Select habit frequency')),
                      20.verticalSpace,
                      const InputFieldLabel(text: 'Habit Color'),

                      /// On Tap, bottom sheet opened for color picker
                      InputField(
                        isDecorationEnable: true,
                        hint: 'Select Habit Color',
                        readOnlyField: true,
                        suffixWidget: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: notifier.habitColor,
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            isScrollControlled: true,
                            builder: (context) {
                              return CustomColorPickerWidget(
                                colorsList: notifier.colorsList,
                                onTap: (color) {
                                  notifier.onSelectColor(color);
                                  FocusScope.of(context).unfocus();
                                },
                              );
                            },
                          );
                        },
                      ),
                      20.verticalSpace,

                      /// On tap, Dialog will open for icon picker
                      const InputFieldLabel(text: 'Habit Icon'),
                      InputField(
                        isDecorationEnable: true,
                        hint: 'Select Habit Icon',
                        readOnlyField: true,
                        suffixWidget: Icon(
                          notifier.iconData ?? Icons.tag_faces,
                          size: 40,
                          color: notifier.habitColor,
                        ),
                        onTap: () {
                          notifier.pickIcon(context: context);
                        },
                      ),
                      20.verticalSpace,

                      /// Description field
                      const InputFieldLabel(text: 'Description'),
                      InputField(
                        controller: notifier.descriptionCntlr,
                        isDecorationEnable: true,
                        hint: 'Add description related to the habit.',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              25.verticalSpace,

              /// Add/Delete/Update Button
              Center(
                  child: CustomButtonWidget(
                btnText: (widget.isAddNewHabit)
                    ? 'Add Habit'
                    : (notifier.isEdit)
                        ? 'Delete'
                        : 'Update Habit',
                onTap: () {
                  if (!widget.isAddNewHabit && notifier.isEdit) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDeleteDialog(onTap: () {
                          notifier.onTapButton(
                              context: context,
                              isAddNewHabit: widget.isAddNewHabit,
                              index: widget.habitIndex);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      },
                    );
                  } else {
                    notifier.onTapButton(
                        context: context,
                        isAddNewHabit: widget.isAddNewHabit,
                        index: widget.habitIndex);
                  }
                },
              )),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
