import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

/// Explains why a closed travel does not accept new expenses.
class FinishedTravelBanner extends StatelessWidget {
  final String message;

  const FinishedTravelBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.amber300.withValues(alpha: isDark ? 0.16 : 0.14),
        border: Border.all(color: AppColors.amber300.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(message, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13))),
        ],
      ),
    );
  }
}
