import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class AuthDivider extends StatelessWidget {
  final String label;

  const AuthDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.slate200)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: textTheme.bodyMedium),
        ),
        const Expanded(child: Divider(color: AppColors.slate200)),
      ],
    );
  }
}
