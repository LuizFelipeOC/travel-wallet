import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'liquid_glass_bottom_bar.dart';

class LiquidGlassBottomBarItem extends StatelessWidget {
  final LiquidGlassNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const LiquidGlassBottomBarItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color idleColor = isDark ? AppColors.slate200 : AppColors.neutral700;
    // Amber on the light amber highlight has too little contrast, so the light
    // theme uses a darker tone for the selected item.
    final Color selectedColor = isDark ? AppColors.amber300 : AppColors.amber700;
    final Color color = isSelected ? selectedColor : idleColor;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(LiquidGlassBottomBar.radius),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: TextStyle(
            fontFamily: 'Inter18',
            fontSize: 11,
            height: 1.1,
            color: color,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                scale: isSelected ? 1.1 : 1,
                child: Icon(isSelected ? item.selectedIcon : item.icon, size: 22, color: color),
              ),
              const SizedBox(height: 4),
              Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
