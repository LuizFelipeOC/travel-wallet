import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class LiquidGlassNavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const LiquidGlassNavItem({required this.icon, required this.label, IconData? selectedIcon})
    : selectedIcon = selectedIcon ?? icon;
}

/// Floating translucent navigation bar. The blur only reads as glass when the
/// content scrolls underneath it, so the host `Scaffold` must set
/// `extendBody: true`.
class LiquidGlassBottomBar extends StatelessWidget {
  final List<LiquidGlassNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const LiquidGlassBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  static const double _height = 64;
  static const double _radius = 32;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color glassTop = isDark
        ? Colors.white.withValues(alpha: 0.14)
        : Colors.white.withValues(alpha: 0.72);
    final Color glassBottom = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.white.withValues(alpha: 0.48);
    final Color borderColor = isDark
        ? Colors.white.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.65);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.16),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_radius),
                  border: Border.all(color: borderColor, width: 1),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [glassTop, glassBottom],
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double itemWidth = constraints.maxWidth / items.length;

                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          left: itemWidth * currentIndex,
                          top: 0,
                          bottom: 0,
                          width: itemWidth,
                          child: Center(
                            child: Container(
                              height: _height - 16,
                              width: itemWidth - 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(_radius),
                                color: AppColors.amber300.withValues(alpha: isDark ? 0.26 : 0.22),
                                border: Border.all(
                                  color: AppColors.amber300.withValues(alpha: 0.45),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            for (int index = 0; index < items.length; index++)
                              Expanded(
                                child: _LiquidGlassBottomBarItem(
                                  item: items[index],
                                  isSelected: index == currentIndex,
                                  onTap: () => onTap(index),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LiquidGlassBottomBarItem extends StatelessWidget {
  final LiquidGlassNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _LiquidGlassBottomBarItem({
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
        borderRadius: BorderRadius.circular(LiquidGlassBottomBar._radius),
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
