import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/constants/constants.dart';
import '../data/models/expense.dart';
import '../state/travel_details_state.dart';
import 'budget_bar_painter.dart';

/// Budget consumption as a single bar split by category. Every change animates
/// from the previous totals, so adding an expense grows the bar and counts the
/// values up instead of snapping.
class BudgetProgress extends StatefulWidget {
  final TravelDetailsLoaded state;

  const BudgetProgress({super.key, required this.state});

  static const Duration animationDuration = Duration(milliseconds: 700);

  @override
  State<BudgetProgress> createState() => _BudgetProgressState();
}

class _BudgetProgressState extends State<BudgetProgress> with SingleTickerProviderStateMixin {
  static const double _height = 14;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: BudgetProgress.animationDuration,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  /// Totals the current animation starts from, and the ones it runs to.
  Map<ExpenseCategory, double> _from = const {};
  late Map<ExpenseCategory, double> _to;

  @override
  void initState() {
    super.initState();

    // The first load grows from zero.
    _to = widget.state.totalsByCategory;
    _controller.forward();
  }

  @override
  void didUpdateWidget(BudgetProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    final totals = widget.state.totalsByCategory;

    if (_mapEquals(totals, _to)) {
      return;
    }

    // Restart from wherever the running animation currently is, so a change
    // mid-flight does not jump back.
    _from = _lerpTotals(_animation.value);
    _to = totals;

    _controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _mapEquals(Map<ExpenseCategory, double> a, Map<ExpenseCategory, double> b) {
    if (a.length != b.length) {
      return false;
    }

    return a.entries.every((entry) => b[entry.key] == entry.value);
  }

  Map<ExpenseCategory, double> _lerpTotals(double t) {
    final categories = {..._from.keys, ..._to.keys};

    return {
      for (final category in categories)
        category: ui.lerpDouble(_from[category] ?? 0, _to[category] ?? 0, t)!,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final currency = NumberFormat.simpleCurrency(locale: locale);
    final budget = widget.state.budget;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final totals = _lerpTotals(_animation.value);
        final spent = totals.values.fold<double>(0, (total, value) => total + value);

        final remaining = budget - spent;
        final isOverBudget = budget > 0 && spent > budget;
        final progress = budget > 0 ? (spent / budget).clamp(0.0, 1.0) : (spent > 0 ? 1.0 : 0.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    budget > 0
                        ? l10n.details_spent_of(currency.format(spent), currency.format(budget))
                        : currency.format(spent),
                    style: theme.textTheme.headlineSmall?.copyWith(fontSize: 20),
                  ),
                ),
                if (budget > 0)
                  Text(
                    '${(progress * 100).round()}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isOverBudget ? theme.colorScheme.error : AppColors.amber700,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: _height,
              width: double.infinity,
              child: CustomPaint(
                painter: BudgetBarPainter(
                  totals: totals,
                  progress: progress,
                  selectedCategory: widget.state.selectedCategory,
                  trackColor: isDark ? AppColors.neutral700 : AppColors.slate200,
                  overBudgetColor: isOverBudget ? theme.colorScheme.error : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              switch ((budget > 0, isOverBudget)) {
                (false, _) => l10n.details_no_budget,
                (true, true) => l10n.details_over_budget(currency.format(remaining.abs())),
                (true, false) => l10n.details_remaining(currency.format(remaining)),
              },
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: isOverBudget ? theme.colorScheme.error : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
