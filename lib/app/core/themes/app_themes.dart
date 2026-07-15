import 'package:flutter/material.dart';

final class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
  );
}
