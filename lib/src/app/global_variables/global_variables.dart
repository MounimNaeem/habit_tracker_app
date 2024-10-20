import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_app/screens/home/provider/habit_provider.dart';


final habitProvider = ChangeNotifierProvider((ref) => HabitProvider(),);