import 'package:flutter/material.dart';

/// A reusable, standalone Flutter widget that displays a minimalist 
/// dual-document comparison checklist layout with custom vector graphics.
class DocumentSelector extends StatefulWidget {
  /// Callback triggered when a document card is tapped. 
  /// Returns `0` for the left card and `1` for the right card.
  final ValueChanged<int>? onSelected;

  /// The stroke and fill line color matching the brand style guide.
  final Color primaryColor;

  const DocumentSelector({
    super.key,
    this.onSelected,
    this.primaryColor = const Color(0xFF1E3A8A), // Default professional blue
  });

  @override
  State<DocumentSelector> createState() => _DocumentSelectorState();
}

class _DocumentSelectorState extends State<DocumentSelector> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    // Dimension presets for layout and tap boxes
    const double cardWidth = 140.0;
    const double cardHeight = 180.0;
    const double gap = 20.0;
    
    const double card1Left = 20.0;
    const double card1Right = card1Left + cardWidth;
    const double card2Left = card1Right + gap;
    const double card2Right = card2Left + cardWidth;
    
    const double cardTop = 30.0;
    const double cardBottom = cardTop + cardHeight;

    // Total wrapper bounding constraint space (Width: 340, Height: 240)
    return GestureDetector(
      onTapDown: (details) {
        final x = details.localPosition.dx;
        final y = details.localPosition.dy;

        int? clickedIndex;

        // Process hit box boundary calculations 
        if (x >= card1Left && x <= card1Right && y >= cardTop && y <= cardBottom) {
          clickedIndex = 0;
        } else if (x >= card2Left && x <= card2Right && y >= cardTop && y <= cardBottom) {
          clickedIndex = 1;
        }

        if (clickedIndex != null) {
          setState(() {
            _selectedIndex = clickedIndex;
          });
          if (widget.onSelected != null) {
            widget.onSelected!(clickedIndex);
          }
        }
      },
      child: CustomPaint(
        size: const Size(340, 240),
        painter: _DocumentVectorPainter(
          selectedIndex: _selectedIndex,
          brandColor: widget.primaryColor,
        ),
      ),
    );
  }
}

class _DocumentVectorPainter extends CustomPainter {
  final int? selectedIndex;
  final Color brandColor;

  _DocumentVectorPainter({
    required this.selectedIndex,
    required this.brandColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = brandColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    const double cardWidth = 140.0;
    const double cardHeight = 180.0;
    const double cardRadius = 12.0;

    final List<Offset> positions = [
      const Offset(20, 30),  // Card 1
      const Offset(180, 30), // Card 2
    ];

    for (int i = 0; i < positions.length; i++) {
      final origin = positions[i];
      final bool isSelected = selectedIndex == i;

      // --- 1. Outer Card Box Outline ---
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = isSelected ? 3.5 : 2.0; // Dynamic emphasis on selection

      final RRect documentRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(origin.dx, origin.dy, cardWidth, cardHeight),
        const Radius.circular(cardRadius),
      );
      canvas.drawRRect(documentRect, paint);

      // --- 2. Checklist Structure Elements ---
      paint.strokeWidth = 2.0;
      const double rowSpacing = 40.0;
      const double startY = 45.0;

      for (int row = 0; row < 3; row++) {
        final double currentY = origin.dy + startY + (row * rowSpacing);

        // Render Vector Checkmark Path
        final Path checkPath = Path()
          ..moveTo(origin.dx + 22, currentY - 2)
          ..lineTo(origin.dx + 27, currentY + 3)
          ..lineTo(origin.dx + 35, currentY - 5);
        canvas.drawPath(checkPath, paint);

        // Render Filled Horizontal Dummy Text Line
        paint.style = PaintingStyle.fill;
        final RRect lineRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(origin.dx + 48, currentY - 2, 68, 4),
          const Radius.circular(2),
        );
        canvas.drawRRect(lineRect, paint);
        paint.style = PaintingStyle.stroke;
      }

      // --- 3. Click Burst Micro-Animation Paths ---
      if (isSelected) {
        final Offset touchOrigin = Offset(origin.dx + cardWidth - 12, origin.dy + cardHeight - 12);
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 1.5;

        // Custom line segments representing the radiant burst rays from the image
        final List<List<Offset>> burstRays = [
          [Offset(touchOrigin.dx - 10, touchOrigin.dy - 5), Offset(touchOrigin.dx - 20, touchOrigin.dy - 8)],
          [Offset(touchOrigin.dx - 6, touchOrigin.dy - 12), Offset(touchOrigin.dx - 12, touchOrigin.dy - 22)],
          [Offset(touchOrigin.dx + 2, touchOrigin.dy - 14), Offset(touchOrigin.dx + 2, touchOrigin.dy - 25)],
          [Offset(touchOrigin.dx + 10, touchOrigin.dy - 8), Offset(touchOrigin.dx + 18, touchOrigin.dy - 17)],
        ];

        for (var ray in burstRays) {
          canvas.drawLine(ray[0], ray[1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DocumentVectorPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex || oldDelegate.brandColor != brandColor;
  }
}
