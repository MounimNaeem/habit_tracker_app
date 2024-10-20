import 'package:flutter/material.dart';
import 'package:habit_tracker_app/src/theme/base_theme_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      hintColor: secondaryColor,
      cardColor: cardColor,
      scaffoldBackgroundColor: scaffoldColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 28,
          fontWeight: FontWeight.w600, // Semi-bold
          color: textColor, // Heading text color
        ),
        displayMedium: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
