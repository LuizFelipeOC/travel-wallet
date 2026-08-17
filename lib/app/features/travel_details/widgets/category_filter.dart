import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../data/models/expense.dart';
import 'category_chip.dart';
import 'expense_category_theme.dart';

class CategoryFilter extends StatelessWidget {
  final List<ExpenseCategory> categories;
  final ExpenseCategory? selected;
  final Map<ExpenseCategory, double> totals;
  final ValueChanged<ExpenseCategory?> onSelected;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selected,
    required this.totals,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final currency = NumberFormat.compactSimpleCurrency(locale: locale);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return CategoryChip(
              label: l10n.filter_all,
              isSelected: selected == null,
              onTap: () => onSelected(null),
            );
          }

          final category = categories[index - 1];

          return CategoryChip(
            label: '${category.label(l10n)} · ${currency.format(totals[category] ?? 0)}',
            color: category.color,
            icon: category.icon,
            isSelected: selected == category,
            onTap: () => onSelected(selected == category ? null : category),
          );
        },
      ),
    );
  }
}
