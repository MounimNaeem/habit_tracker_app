import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habit_tracker_app/screens/home/model/habit_model_class.dart';
import 'package:habit_tracker_app/services/shared_preference.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';
import 'package:motion_toast/motion_toast.dart';

class HabitProvider extends ChangeNotifier {
  Color habitColor = cardColor;
  IconData? iconData;
  int completeHabit = 0;
  bool isEdit = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController habitNameCntlr = TextEditingController();
  TextEditingController descriptionCntlr = TextEditingController();
  SingleValueDropDownController categoryCntlr = SingleValueDropDownController();
  SingleValueDropDownController repeatCntlr = SingleValueDropDownController();

  List<HabitModelClass> habitList = [];

  /// Custom color list
  List<Color> colorsList = const [
    Color(0xFF0D47A1),
    Color(0xFF9A8700),
    Color(0xFF4B0082),
    Color(0xFFFF5C00),
    Color(0xFF37C871),
    Color(0xff443a49),
    Color(0xff443a49),
    Color(0xFFFFDAB9)
  ];

  /// Category list
  List<DropDownValueModel> categories = const [
    DropDownValueModel(name: 'Health', value: "Health"),
    DropDownValueModel(name: 'Fitness', value: "Fitness"),
    DropDownValueModel(name: 'Productivity', value: "Productivity"),
    DropDownValueModel(name: 'Personal Growth', value: "Personal Growth"),
    DropDownValueModel(name: 'Well-being', value: "Well-being"),
    DropDownValueModel(name: 'Daily Routine', value: "Daily Routine"),
    DropDownValueModel(name: 'Finance', value: "Finance"),
  ];

  /// Repeat list
  List<DropDownValueModel> repeat = const [
    DropDownValueModel(name: 'Daily', value: "Daily"),
    DropDownValueModel(name: 'Weekly', value: "Weekly"),
    DropDownValueModel(name: 'Monthly', value: "Monthly"),
  ];

  /// Provider Init
  void providerInit() {
    List<HabitModelClass> list = SharedPreferencesService().getHabitList();
    habitList.addAll(list);
    completeHabit = habitList.where((element) => element.isCompleted).length;
    notifyListeners();
  }

  /// Assigning data to controllers for edit or view habit in detail
  void addNewHabitScreenInit({required int index}) {
    isEdit = true;
    habitNameCntlr.text = habitList[index].habitName;
    categoryCntlr.dropDownValue = DropDownValueModel(
        name: habitList[index].category, value: habitList[index].category);
    repeatCntlr.dropDownValue = DropDownValueModel(
        name: habitList[index].habitDays, value: habitList[index].habitDays);
    habitColor = habitList[index].habitColor ?? cardColor;
    iconData = habitList[index].habitIcon ?? Icons.tag_faces;
    descriptionCntlr.text = habitList[index].habitDescription;
  }

  /// On Tap Add/Delete/Update Button
  void onTapButton(
      {required BuildContext context,
      required bool isAddNewHabit,
      int? index}) {
    if (isAddNewHabit) {
      /// add new habit
      addNewHabit(context);
    } else if (!isAddNewHabit && isEdit) {
      /// Delete habit
      deleteHabit(index: index!, context: context);
    } else if (!isAddNewHabit && !isEdit) {
      /// update habit
      updateHabit(index: index!, context: context);
    }
  }

  /// Function for add new habit
  void addNewHabit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      habitList.add(HabitModelClass(
        id: DateTime.now().microsecondsSinceEpoch,
        habitName: habitNameCntlr.text.trim(),
        category: categoryCntlr.dropDownValue?.value,
        habitDescription: descriptionCntlr.text.trim(),
        habitDays: repeatCntlr.dropDownValue?.value,
        habitIcon: iconData,
        habitColor: habitColor,
      ));

      /// saving habit list in local DB
      SharedPreferencesService().saveHabitList(habitList);
      MotionToast.success(
          description: const Text('Successfully new habit created'))
          .show(context);
      Navigator.pop(context);
      notifyListeners();
      disposeAddHabitViewController();
    }

  }

  /// Function for delete habit
  void deleteHabit({required int index, required BuildContext context}) {
    habitList.removeAt(index);
    SharedPreferencesService().saveHabitList(habitList);
    MotionToast.success(description: const Text('Habit delete Successfully'))
        .show(context);
    completeHabit = 0;
    disposeAddHabitViewController();
    notifyListeners();
  }

  /// Function for updating habit
  void updateHabit({required int index, required BuildContext context}) {
    HabitModelClass updatedHabit = HabitModelClass(
        id: habitList[index].id,
        habitName: habitNameCntlr.text.trim(),
        category: categoryCntlr.dropDownValue?.value,
        habitDescription: descriptionCntlr.text.trim(),
        habitDays: repeatCntlr.dropDownValue?.value,
        habitIcon: iconData,
        habitColor: habitColor,
        isCompleted: habitList[index].isCompleted);
    habitList[index] = updatedHabit;
    SharedPreferencesService().saveHabitList(habitList);
    MotionToast.success(description: const Text('Habit Successfully updated'))
        .show(context);
    Navigator.pop(context);
    notifyListeners();
    disposeAddHabitViewController();
  }

  /// Function for mark habit status as complete
  void markHabitCompleted(int index) {
    habitList[index].isCompleted = !habitList[index].isCompleted;
    if (habitList.isEmpty) {
      completeHabit = 0;
    }
    {
      completeHabit = habitList.where((element) => element.isCompleted).length;
    }

    /// Sorting list, move the complete habits at the end of list
    habitList.sort((a, b) {
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      return a.id.compareTo(b.id);
    });
    notifyListeners();
  }

  /// Function for selecting color
  void onSelectColor(Color color) {
    habitColor = color;
    notifyListeners();
  }

  /// Function for selecting icon
  void pickIcon({required BuildContext context}) async {
    IconPickerIcon? pickIcon = await showIconPicker(
      context,
      configuration: const SinglePickerConfiguration(
        iconPackModes: [IconPack.allMaterial, IconPack.fontAwesomeIcons],
      ),
    );

    iconData = pickIcon?.data;
    debugPrint('Picked Icon:  ${pickIcon?.data} ${pickIcon?.name}');
    notifyListeners();
  }

  /// Form field validator
  String? habitNameValidator({String? value, required String msg}) {
    if (value == null || value.isEmpty) {
      return msg;
    } else {
      return null;
    }
  }

  /// On tap edit icon
  void onTapEditIcon() {
    isEdit = !isEdit;
    notifyListeners();
  }

  /// Dispose controllers
  void disposeAddHabitViewController() {
    habitNameCntlr = TextEditingController();
    descriptionCntlr = TextEditingController();
    categoryCntlr = SingleValueDropDownController();
    repeatCntlr = SingleValueDropDownController();
    habitColor = cardColor;
    iconData = null;
  }
}
