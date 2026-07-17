import 'package:flutter/material.dart';

final class AppColors {
  static const Color primaryColor = Color(0xFF163592);

  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [Color(0xFF163592), Color(0xFF1E4D9B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
