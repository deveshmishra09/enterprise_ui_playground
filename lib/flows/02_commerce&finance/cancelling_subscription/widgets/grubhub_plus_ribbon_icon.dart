import 'package:flutter/material.dart';

class GrubhubPlusRibbonIcon extends StatelessWidget {
  final double size;

  /// Creates a custom painter widget for the Grubhub+ ribbon banner badge.
  /// [size] determines the uniform square layout canvas bounds.
  const GrubhubPlusRibbonIcon({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: GrubhubPlusRibbonPainter(),
    );
  }
}

class GrubhubPlusRibbonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 1. Draw the Gold Banner Body
    final Paint bannerPaint = Paint()
      ..color = const Color(0xFFE5A93C) // Rich gold/mustard color from image
      ..style = PaintingStyle.fill;

    final Path bannerPath = Path()
      ..moveTo(w * 0.1, h * 0.1)  // Top-left
      ..lineTo(w * 0.9, h * 0.1)  // Top-right
      ..lineTo(w * 0.72, h * 0.5) // Center-right inward point (chevron cut)
      ..lineTo(w * 0.9, h * 0.9)  // Bottom-right
      ..lineTo(w * 0.1, h * 0.9)  // Bottom-left
      ..close();
    
    canvas.drawPath(bannerPath, bannerPaint);

    // 2. Draw the Black Center Cross (+)
    final Paint crossPaint = Paint()
      ..color = const Color(0xFF0F1219) // Near-black dark color matching the UI background tone
      ..style = PaintingStyle.fill;

    // Calculate center relative to the solid left square block area of the banner
    final double cx = w * 0.42; 
    final double cy = h * 0.5;
    final double thick = w * 0.12;  // Thickness of cross bars
    final double length = w * 0.36; // Total span length of cross bars

    // Horizontal bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - length / 2, cy - thick / 2, length, thick),
        Radius.circular(thick * 0.2),
      ),
      crossPaint,
    );

    // Vertical bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - thick / 2, cy - length / 2, thick, length),
        Radius.circular(thick * 0.2),
      ),
      crossPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
