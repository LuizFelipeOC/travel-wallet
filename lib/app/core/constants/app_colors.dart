import 'package:flutter/material.dart';

final class AppColors {
  static const Color amber300 = Color(0xFFfbbf24);

  static const Color slate50 = Color(0xFFf8fafc);
  static const Color slate100 = Color(0xFFf1f5f9);
  static const Color slate200 = Color(0xFFe2e8f0);
  static const Color slate800 = Color(0xFF1e293b);

  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);

  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [Color(0xFF163592), Color(0xFF1E4D9B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
