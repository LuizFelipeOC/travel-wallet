import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../data/models/expense.dart';

/// Colour and label for each category, shared by the progress bar, the filter
/// chips and the expense list so a category always reads the same.
extension ExpenseCategoryTheme on ExpenseCategory {
  Color get color => switch (this) {
    ExpenseCategory.lodging => const Color(0xFF6366F1),
    ExpenseCategory.transport => const Color(0xFF0EA5E9),
    ExpenseCategory.food => const Color(0xFFF97316),
    ExpenseCategory.leisure => const Color(0xFF10B981),
    ExpenseCategory.shopping => const Color(0xFFEC4899),
    ExpenseCategory.other => const Color(0xFF94A3B8),
  };

  IconData get icon => switch (this) {
    ExpenseCategory.lodging => Icons.hotel_outlined,
    ExpenseCategory.transport => Icons.directions_bus_outlined,
    ExpenseCategory.food => Icons.restaurant_outlined,
    ExpenseCategory.leisure => Icons.beach_access_outlined,
    ExpenseCategory.shopping => Icons.shopping_bag_outlined,
    ExpenseCategory.other => Icons.more_horiz,
  };

  String label(AppLocalizations l10n) => switch (this) {
    ExpenseCategory.lodging => l10n.category_lodging,
    ExpenseCategory.transport => l10n.category_transport,
    ExpenseCategory.food => l10n.category_food,
    ExpenseCategory.leisure => l10n.category_leisure,
    ExpenseCategory.shopping => l10n.category_shopping,
    ExpenseCategory.other => l10n.category_other,
  };
}
