import 'package:flutter/material.dart';

/// Paints a faint two-layer square grid behind [child] — a fine 24px grid plus
/// a heavier 120px grid — in both light and dark themes, no image asset.
///
/// Values mirror withanimation.app: 1px lines tinted from the foreground color
/// at ~1.75% (minor) and ~2.1–2.5% (major) alpha over the scaffold background.
class GridBackground extends StatelessWidget {
  const GridBackground({super.key, required this.child});

  final Widget child;

  static const double minorStep = 24;
  static const double majorStep = 120;
  static const double minorAlpha = 0.0175;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomPaint(
      painter: _GridPainter(
        tint: Theme.of(context).colorScheme.onSurface,
        majorAlpha: isDark ? 0.02125 : 0.025,
      ),
      child: child,
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.tint, required this.majorAlpha});

  final Color tint;
  final double majorAlpha;

  void _grid(Canvas canvas, Size size, double step, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var x = 0.0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _grid(
      canvas,
      size,
      GridBackground.minorStep,
      tint.withValues(alpha: GridBackground.minorAlpha),
    );
    _grid(
      canvas,
      size,
      GridBackground.majorStep,
      tint.withValues(alpha: majorAlpha),
    );
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) =>
      oldDelegate.tint != tint || oldDelegate.majorAlpha != majorAlpha;
}
