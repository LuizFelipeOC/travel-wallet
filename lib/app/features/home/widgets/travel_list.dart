import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/constants.dart';
import '../../traveler_planner/traveler_planner_form/data/models/create_form_request.dart';

class TravelList extends StatelessWidget {
  final List<CreateFormRequestModel> travels;
  final EdgeInsets padding;

  const TravelList({super.key, required this.travels, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemCount: travels.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _TravelTile(travel: travels[index]),
      ),
    );
  }
}

class _TravelTile extends StatelessWidget {
  final CreateFormRequestModel travel;

  const _TravelTile({required this.travel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).toString();

    final dateFormat = DateFormat.yMMMd(locale);
    final currencyFormat = NumberFormat.simpleCurrency(locale: locale);

    final budget = double.tryParse(travel.budgetPlan.replaceAll(',', '.'));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? AppColors.neutral700.withValues(alpha: 0.35) : AppColors.slate50,
        border: Border.all(
          color: isDark ? AppColors.neutral700 : AppColors.slate200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.amber300.withValues(alpha: 0.2),
            ),
            child: const Icon(Icons.place_outlined),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  travel.travelName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${dateFormat.format(travel.startDate)} - ${dateFormat.format(travel.endDate)}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            budget == null ? travel.budgetPlan : currencyFormat.format(budget),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.amber700,
            ),
          ),
        ],
      ),
    );
  }
}
