import 'package:flutter/material.dart';

/// The Google "G" drawn locally so the button does not depend on a network
/// image or an extra asset.
class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 20, width: 20, child: CustomPaint(painter: GoogleLogoPainter()));
  }
}

class GoogleLogoPainter extends CustomPainter {
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
  bool shouldRepaint(covariant GoogleLogoPainter oldDelegate) => false;
}
