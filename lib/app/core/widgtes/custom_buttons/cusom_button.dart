import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final String title;
  final bool isLoading;
  final bool isDisabled;
  final bool isOutlined;
  final double height;
  final double width;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.style,
    this.isLoading = false,
    this.isDisabled = false,
    this.isOutlined = false,
    this.height = 50,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: isLoading
          ? Row(
              key: const ValueKey('loading'),
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(title),
              ],
            )
          : Text(title, key: const ValueKey('title')),
    );

    if (isOutlined) {
      return SizedBox(
        height: height,
        width: width,
        child: OutlinedButton(
          onPressed: isDisabled || isLoading ? null : onPressed,
          style: style,
          child: content,
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: style,
        child: content,
      ),
    );
  }
}
