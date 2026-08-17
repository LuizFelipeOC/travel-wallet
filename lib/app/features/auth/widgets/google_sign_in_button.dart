import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import 'google_logo.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String title;

  const GoogleSignInButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.slate200, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const GoogleLogo(),
                    const SizedBox(width: 12),
                    Text(title, style: textTheme.bodyMedium),
                  ],
                ),
        ),
      ),
    );
  }
}
