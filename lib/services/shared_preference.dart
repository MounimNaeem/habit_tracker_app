import 'dart:convert';

import 'package:habit_tracker_app/screens/home/model/habit_model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String habitListKey = "habitListKey";

  static final SharedPreferencesService _instance =
      SharedPreferencesService._();

  SharedPreferencesService._();

  factory SharedPreferencesService() {
    return _instance;
  }

  late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///------------------Get Habit list from preference

  List<HabitModelClass> getHabitList() {
    String? habitListString = _prefs.getString('habitListKey');

    if (habitListString != null) {
      List<dynamic> jsonList = jsonDecode(habitListString);
      return jsonList.map((json) => HabitModelClass.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  ///--------------------Save Habit list to preference
  void saveHabitList(List<HabitModelClass> habitList) {
    _prefs.setString(habitListKey,
        jsonEncode(habitList.map((habit) => habit.toJson()).toList()));
  }

  ///--------------------Clear User
  void clearUser() {
    _prefs.remove(habitListKey);
  }
}
