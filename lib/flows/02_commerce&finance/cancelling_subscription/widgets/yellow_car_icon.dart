import 'package:flutter/material.dart';

class YellowCarIcon extends StatelessWidget {
  final double size;

  /// Creates a custom painter widget for the yellow car icon.
  /// [size] determines the total dimensions of the canvas area.
  const YellowCarIcon({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 0.8), // Car dimensions are slightly wider than tall
      painter: YellowCarPainter(),
    );
  }
}

class YellowCarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Paints configuration
    final Paint carYellow = Paint()..color = const Color(0xFFFFD54F);
    final Paint darkYellow = Paint()..color = const Color(0xFFFBC02D);
    final Paint windowBlue = Paint()..color = const Color(0xFFE0F7FA);
    final Paint wheelBlack = Paint()..color = const Color(0xFF37474F);
    final Paint wheelHub = Paint()..color = const Color(0xFFCFD8DC);

    // 1. Lower Main Car Body Chassis
    final RRect lowerBody = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.4, w * 0.8, h * 0.35),
      Radius.circular(w * 0.08),
    );
    canvas.drawRRect(lowerBody, carYellow);

    // 2. Upper Cabin Roof Architecture
    final Path cabinPath = Path()
      ..moveTo(w * 0.22, h * 0.4)
      ..lineTo(w * 0.35, h * 0.15)
      ..lineTo(w * 0.65, h * 0.15)
      ..lineTo(w * 0.78, h * 0.4)
      ..close();
    canvas.drawPath(cabinPath, darkYellow);

    // 3. Passenger Windows Layout
    final Path frontWindow = Path()
      ..moveTo(w * 0.26, h * 0.37)
      ..lineTo(w * 0.36, h * 0.18)
      ..lineTo(w * 0.48, h * 0.18)
      ..lineTo(w * 0.48, h * 0.37)
      ..close();
    canvas.drawPath(frontWindow, windowBlue);

    final Path backWindow = Path()
      ..moveTo(w * 0.52, h * 0.37)
      ..lineTo(w * 0.52, h * 0.18)
      ..lineTo(w * 0.64, h * 0.18)
      ..lineTo(w * 0.74, h * 0.37)
      ..close();
    canvas.drawPath(backWindow, windowBlue);

    // 4. Protective Mudguards / Wheel Arches
    canvas.drawArc(Rect.fromCircle(center: Offset(w * 0.3, h * 0.75), radius: w * 0.15), 3.14, 3.14, false, darkYellow);
    canvas.drawArc(Rect.fromCircle(center: Offset(w * 0.7, h * 0.75), radius: w * 0.15), 3.14, 3.14, false, darkYellow);

    // 5. Wheels Assemblies (Rubber Tires + Alloy Rims)
    canvas.drawCircle(Offset(w * 0.3, h * 0.72), w * 0.12, wheelBlack);
    canvas.drawCircle(Offset(w * 0.3, h * 0.72), w * 0.05, wheelHub);

    canvas.drawCircle(Offset(w * 0.7, h * 0.72), w * 0.12, wheelBlack);
    canvas.drawCircle(Offset(w * 0.7, h * 0.72), w * 0.05, wheelHub);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
