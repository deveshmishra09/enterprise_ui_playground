import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Center(child: GrubhubIcon()))));

class GrubhubIcon extends StatelessWidget {
  final double size;

  const GrubhubIcon({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: GrubhubLogoPainter(),
    );
  }
}

class GrubhubLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    // 1. Draw the Circular Background Disc
    final Paint bgPaint = Paint()
      ..color = const Color(0xFF4C4C6D) // Deep grey-blue background shade
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // 2. Draw the Shopping Bag Handle
    final Paint handlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05
      ..strokeCap = StrokeCap.round;

    final Rect handleRect = Rect.fromCenter(
      center: Offset(radius, size.height * 0.38),
      width: size.width * 0.16,
      height: size.height * 0.22,
    );
    // Draw the top semi-circle handle arch
    canvas.drawArc(handleRect, 3.14159, 3.14159, false, handlePaint);

    // 3. Draw the Shopping Bag Body
    final Paint bagPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Path bagPath = Path();
    double bagTop = size.height * 0.38;
    double bagBottom = size.height * 0.76;
    double bagLeft = size.width * 0.35;
    double bagRight = size.width * 0.65;
    double flare = size.width * 0.03; // Slight outward widening angle toward the bottom

    bagPath.moveTo(bagLeft, bagTop);
    bagPath.lineTo(bagRight, bagTop);
    bagPath.lineTo(bagRight + flare, bagBottom);
    bagPath.lineTo(bagLeft - flare, bagBottom);
    bagPath.close();

    canvas.drawPath(bagPath, bagPaint);

    // 4. Draw the Cut-Out Text Letters ("G" and "H")
    final Paint cutPaint = Paint()
      ..color = const Color(0xFF4C4C6D) // Same as background to mimic a cutout
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.square;

    // --- Draw Letter 'G' ---
    final double gLeft = size.width * 0.41;
    final double gRight = size.width * 0.49;
    final double letterTop = size.height * 0.47;
    final double letterBottom = size.height * 0.67;
    final double letterMid = (letterTop + letterBottom) / 2;

    final Path gPath = Path()
      ..moveTo(gRight, letterTop)
      ..lineTo(gLeft, letterTop)
      ..lineTo(gLeft, letterBottom)
      ..lineTo(gRight, letterBottom)
      ..lineTo(gRight, letterMid)
      ..lineTo(gRight - (size.width * 0.04), letterMid);
    canvas.drawPath(gPath, cutPaint);

    // --- Draw Letter 'H' ---
    final double hLeft = size.width * 0.53;
    final double hRight = size.width * 0.61;

    // Left vertical stroke
    canvas.drawLine(Offset(hLeft, letterTop), Offset(hLeft, letterBottom), cutPaint);
    // Right vertical stroke
    canvas.drawLine(Offset(hRight, letterTop), Offset(hRight, letterBottom), cutPaint);
    // Middle horizontal connection bar
    canvas.drawLine(Offset(hLeft, letterMid), Offset(hRight, letterMid), cutPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
