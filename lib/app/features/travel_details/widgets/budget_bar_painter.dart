import 'package:flutter/material.dart';

import '../data/models/expense.dart';
import 'expense_category_theme.dart';

/// Paints the budget bar: a rounded track with one slice per category.
class BudgetBarPainter extends CustomPainter {
  final Map<ExpenseCategory, double> totals;
  final double progress;
  final ExpenseCategory? selectedCategory;
  final Color trackColor;
  final Color? overBudgetColor;

  BudgetBarPainter({
    required this.totals,
    required this.progress,
    required this.selectedCategory,
    required this.trackColor,
    this.overBudgetColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height / 2);
    final track = RRect.fromRectAndRadius(Offset.zero & size, radius);

    canvas.drawRRect(track, Paint()..color = trackColor);
    canvas.save();
    canvas.clipRRect(track);

    final spent = totals.values.fold<double>(0, (total, value) => total + value);

    if (spent > 0) {
      final barWidth = size.width * progress;

      double x = 0;

      for (final entry in totals.entries) {
        final width = (entry.value / spent) * barWidth;

        if (width <= 0) {
          continue;
        }

        final color = overBudgetColor ?? entry.key.color;
        final isDimmed = selectedCategory != null && selectedCategory != entry.key;

        canvas.drawRect(
          Rect.fromLTWH(x, 0, width, size.height),
          Paint()..color = isDimmed ? color.withValues(alpha: 0.3) : color,
        );

        x += width;
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BudgetBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.selectedCategory != selectedCategory ||
        oldDelegate.overBudgetColor != overBudgetColor ||
        oldDelegate.trackColor != trackColor ||
        !identical(oldDelegate.totals, totals);
  }
}
