import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

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
                    const _GoogleLogo(),
                    const SizedBox(width: 12),
                    Text(title, style: textTheme.bodyMedium),
                  ],
                ),
        ),
      ),
    );
  }
}

/// The Google "G" drawn locally so the button does not depend on a network
/// image or an extra asset.
class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  static const Color _blue = Color(0xFF4285F4);
  static const Color _red = Color(0xFFEA4335);
  static const Color _yellow = Color(0xFFFBBC05);
  static const Color _green = Color(0xFF34A853);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final strokeWidth = size.width * 0.22;
    final arcRect = rect.deflate(strokeWidth / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    void arc(double startDegrees, double sweepDegrees, Color color) {
      paint.color = color;
      canvas.drawArc(arcRect, _radians(startDegrees), _radians(sweepDegrees), false, paint);
    }

    arc(-40, -100, _red);
    arc(-140, -100, _yellow);
    arc(120, 90, _green);
    arc(-40, 60, _blue);

    // Horizontal bar of the "G".
    final barPaint = Paint()..color = _blue;
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.5, size.height * 0.4, size.width * 0.5, strokeWidth),
      barPaint,
    );
  }

  double _radians(double degrees) => degrees * 3.1415926535897932 / 180;

  @override
  bool shouldRepaint(covariant _GoogleLogoPainter oldDelegate) => false;
}
