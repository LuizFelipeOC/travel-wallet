import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

final class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.amber300,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter18',
    useMaterial3: false,
    textTheme: textTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    textButtonTheme: textButtonTheme(),
    iconButtonTheme: iconButtonTheme(),
    iconTheme: iconThemeData(),
    appBarTheme: appBarTheme(Brightness.light),
    textSelectionTheme: textSelectionTheme(),
    outlinedButtonTheme: outlinedButtonTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.amber300, brightness: Brightness.light),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.amber300,
    scaffoldBackgroundColor: AppColors.neutral800,
    fontFamily: 'Inter18',
    useMaterial3: false,
    textTheme: darkTextTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    inputDecorationTheme: darkInputDecorationTheme(),
    textButtonTheme: textButtonTheme(),
    iconButtonTheme: iconButtonTheme(),
    iconTheme: iconThemeData(),
    appBarTheme: appBarTheme(Brightness.dark),
    textSelectionTheme: textSelectionTheme(),
    outlinedButtonTheme: outlinedButtonTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.amber300, brightness: Brightness.dark),
  );

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.amber300,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      labelStyle: const TextStyle(color: Colors.black87),
      suffixIconColor: AppColors.amber300,
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
        borderSide: BorderSide(color: AppColors.amber300, width: 2),
      ),
    );
  }

  static InputDecorationTheme darkInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral800,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      labelStyle: const TextStyle(color: Colors.white),
      suffixIconColor: AppColors.amber300,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.amber300, width: 2),
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.amber300,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.neutral800,
        height: 1.3,
        letterSpacing: 0.5,
        wordSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.neutral800,
        height: 1.3,
        letterSpacing: 0.5,
        wordSpacing: 0.5,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static TextTheme darkTextTheme() {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.slate50,
        height: 1.3,
        letterSpacing: 0.5,
        wordSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.slate200,
        height: 1.3,
        letterSpacing: 0.5,
        wordSpacing: 0.5,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static IconButtonThemeData iconButtonTheme() {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.amber300,
        iconSize: 22,
        padding: EdgeInsets.zero,
      ),
    );
  }

  static IconThemeData iconThemeData() {
    return const IconThemeData(color: AppColors.amber300, size: 22);
  }

  static AppBarTheme appBarTheme(Brightness brightness) {
    final system = (brightness == Brightness.dark)
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: iconThemeData(),
      titleTextStyle: textTheme().headlineSmall,
      toolbarTextStyle: textTheme().bodyMedium,
      systemOverlayStyle: system,
    );
  }

  static TextSelectionThemeData textSelectionTheme() {
    return const TextSelectionThemeData(
      cursorColor: AppColors.amber300,
      selectionColor: AppColors.amber300,
      selectionHandleColor: AppColors.amber300,
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.amber300,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        side: const BorderSide(color: AppColors.amber300, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
