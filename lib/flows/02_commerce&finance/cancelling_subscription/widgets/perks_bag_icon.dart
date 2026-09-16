import 'package:flutter/material.dart';

class PerksBagIcon extends StatelessWidget {
  final double size;

  /// Creates a custom painter widget for the perks double shopping bag icon.
  /// [size] determines the uniform square layout canvas bounds.
  const PerksBagIcon({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: PerksBagPainter(),
    );
  }
}

class PerksBagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Palette setup
    final Paint backBagPaint = Paint()..color = const Color(0xFFFEE87E);
    final Paint frontBagPaint = Paint()..color = const Color(0xFFFFD54F);
    
    final Paint handlePaint = Paint()
      ..color = const Color(0xFFFFE082)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.04
      ..strokeCap = StrokeCap.round;

    // 1. Back/Background Bag Carrying Handles
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.42, h * 0.32), width: w * 0.14, height: w * 0.18), 3.14, 3.14, false, handlePaint);
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.58, h * 0.35), width: w * 0.14, height: w * 0.18), 3.14, 3.14, false, handlePaint);

    // 2. Back Secondary Bag Segment (Rotated Left)
    canvas.save();
    canvas.translate(w * 0.42, h * 0.6);
    canvas.rotate(-0.12); // Counter-clockwise offset angle
    canvas.translate(-w * 0.22, -h * 0.25);
    final Path backPath = Path()
      ..moveTo(w * 0.04, 0)
      ..lineTo(w * 0.4, 0)
      ..lineTo(w * 0.44, h * 0.46)
      ..lineTo(0, h * 0.46)
      ..close();
    canvas.drawPath(backPath, backBagPaint);
    canvas.restore();

    // 3. Front Main Bag Segment (Rotated Right)
    canvas.save();
    canvas.translate(w * 0.56, h * 0.62);
    canvas.rotate(0.08); // Clockwise offset angle
    canvas.translate(-w * 0.24, -h * 0.25);
    
    final Path frontPath = Path()
      ..moveTo(w * 0.04, 0)
      ..lineTo(w * 0.44, 0)
      ..lineTo(w * 0.48, h * 0.46)
      ..lineTo(0, h * 0.46)
      ..close();
    canvas.drawPath(frontPath, frontBagPaint);

    // 4. Center Hanging Bookmark / Ribbon Banner Embellishment
    final Paint ribbonPaint = Paint()..color = const Color(0xFFFFF5CC);
    final Path ribbonPath = Path()
      ..moveTo(w * 0.12, h * 0.12)
      ..lineTo(w * 0.36, h * 0.12)
      ..lineTo(w * 0.36, h * 0.36)
      ..lineTo(w * 0.24, h * 0.28) // Bottom inward V-notch calculation
      ..lineTo(w * 0.12, h * 0.36)
      ..close();
    canvas.drawPath(ribbonPath, ribbonPaint);

    // 5. Minimalist Dark Accent Cross Symbol (+)
    final Paint crossPaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.fill;
    
    double cx = w * 0.24;
    double cy = h * 0.20;
    double thick = w * 0.04;
    double length = w * 0.12;

    // Horizontal geometry block
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(cx - length / 2, cy - thick / 2, length, thick), Radius.circular(thick / 2)), crossPaint);
    // Vertical geometry block
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(cx - thick / 2, cy - length / 2, thick, length), Radius.circular(thick / 2)), crossPaint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
