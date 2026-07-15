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
    if (isOutlined) {
      return SizedBox(
        height: height,
        width: width,
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: Text(title),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(onPressed: onPressed, style: style, child: Text(title)),
    );
  }
}
