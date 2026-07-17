import 'package:flutter/material.dart';

import '../constants/constants.dart';

final class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter18',
    useMaterial3: false,
    textTheme: textTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    textButtonTheme: textButtonTheme(),
  );

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      labelStyle: const TextStyle(color: Colors.black87),
      suffixIconColor: AppColors.primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
    );
  }

  static TextTheme textTheme() {
    return const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: .bold,
        color: Colors.black,
        height: 1.3,
        letterSpacing: 0.5,
        wordSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
        height: 1.3,
        letterSpacing: 0.5,
        wordSpacing: 0.5,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
