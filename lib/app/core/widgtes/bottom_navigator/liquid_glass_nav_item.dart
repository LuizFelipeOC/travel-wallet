import 'package:flutter/material.dart';

class LiquidGlassNavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const LiquidGlassNavItem({required this.icon, required this.label, IconData? selectedIcon})
    : selectedIcon = selectedIcon ?? icon;
}
