import 'package:flutter/cupertino.dart';

class HabitModelClass {
  int id;
  String habitName;
  String category;
  String habitDescription;
  String habitDays;
  IconData? habitIcon;
  Color? habitColor;
  bool isCompleted;

  // Constructor
  HabitModelClass({
    required this.id,
    required this.habitName,
    required this.category,
    required this.habitDescription,
    required this.habitDays,
    this.habitIcon,
    this.habitColor,
    this.isCompleted = false,
  });

  // Factory method for creating a Habit object from JSON
  factory HabitModelClass.fromJson(Map<String, dynamic> json) {
    return HabitModelClass(
      id: json['id'],
      habitName: json['habitName'],
      category: json['category'],
      habitDescription: json['habitDescription'],
      habitDays: json['habitDays'],
      habitIcon: json['habitIcon'] != null
          ? IconData(json['habitIcon'], fontFamily: 'MaterialIcons')
          : null,
      habitColor: json['habitColor'] != null ? Color(json['habitColor']) : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Method for converting a Habit object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habitName': habitName,
      'category': category,
      'habitDescription': habitDescription,
      'habitDays': habitDays,
      'habitIcon': habitIcon?.codePoint,
      'habitColor': habitColor?.value,
      'isCompleted': isCompleted,
    };
  }
}
