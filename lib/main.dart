import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker_app/screens/home/view/home_view.dart';
import 'package:habit_tracker_app/services/shared_preference.dart';
import 'package:habit_tracker_app/src/theme/custom_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        title: 'Habit Tracker App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home:const HomeView(),
      ),
    );
  }
}

