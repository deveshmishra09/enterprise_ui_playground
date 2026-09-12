import 'package:flutter/material.dart';

// Helper custom painter to recreate the credit cards icon
class CreditCardsPainter extends CustomPainter {
  const CreditCardsPainter({this.color = const Color(0xFF2B579A)});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // --- 1. Draw Back Card ---
    // Positions relative to total size
    final backLeft = w * 0.28;
    final backTop = h * 0.12;
    final backRight = w * 0.92;
    final backBottom = h * 0.72;
    final backRadius = Radius.circular(w * 0.06);

    final backCardPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTRB(backLeft, backTop, backRight, backBottom),
        backRadius,
      ));
    canvas.drawPath(backCardPath, paint);

    // --- 2. Draw Front Card ---
    final frontLeft = w * 0.08;
    final frontTop = h * 0.32;
    final frontRight = w * 0.72;
    final frontBottom = h * 0.92;
    final frontRadius = Radius.circular(w * 0.06);

    final frontCardPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTRB(frontLeft, frontTop, frontRight, frontBottom),
        frontRadius,
      ));
    canvas.drawPath(frontCardPath, paint);

    // --- 3. Draw Magnetic Strip ---
    final stripY = frontTop + (frontBottom - frontTop) * 0.28;
    canvas.drawLine(
      Offset(frontLeft, stripY),
      Offset(frontRight, stripY),
      paint,
    );

    // --- 4. Draw Bottom-Left Info Lines ---
    final line1Y = frontTop + (frontBottom - frontTop) * 0.58;
    final line2Y = frontTop + (frontBottom - frontTop) * 0.76;
    final lineStartX = frontLeft + (frontRight - frontLeft) * 0.15;
    final lineEndX = frontLeft + (frontRight - frontLeft) * 0.42;

    canvas.drawLine(Offset(lineStartX, line1Y), Offset(lineEndX, line1Y), paint);
    canvas.drawLine(Offset(lineStartX, line2Y), Offset(lineEndX, line2Y), paint);

    // --- 5. Draw Mastercard-style Overlapping Circles ---
    final circleRadius = (frontBottom - frontTop) * 0.13;
    final circleY = frontTop + (frontBottom - frontTop) * 0.68;
    
    // Left circle center
    final leftCircleX = frontRight - (frontRight - frontLeft) * 0.32;
    // Right circle center (shifted slightly to overlap)
    final rightCircleX = leftCircleX + circleRadius * 1.1;

    // Draw left circle
    canvas.drawCircle(Offset(leftCircleX, circleY), circleRadius, paint);
    // Draw right circle
    canvas.drawCircle(Offset(rightCircleX, circleY), circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CreditCardsPainter oldDelegate) => 
      oldDelegate.color != color;
}
