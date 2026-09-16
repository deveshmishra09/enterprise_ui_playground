import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Center(child: VoucherIcon()))));

class VoucherIcon extends StatelessWidget {
  final double size;

  const VoucherIcon({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: DonationVoucherPainter(),
    );
  }
}

class DonationVoucherPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // --- 1. Draw the Background / Back Ticket ---
    final Paint backTicketPaint = Paint()
      ..color = const Color(0xFFFEE87E)
      ..style = PaintingStyle.fill;

    canvas.save();
    // Rotate and shift slightly for the stacked look
    canvas.translate(w * 0.45, h * 0.45);
    canvas.rotate(-0.15); // Slight tilt to the left
    canvas.translate(-w * 0.3, -h * 0.2);
    
    final RRect backTicket = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w * 0.6, h * 0.4),
      Radius.circular(w * 0.04),
    );
    canvas.drawRRect(backTicket, backTicketPaint);
    canvas.restore();


    // --- 2. Draw the Front Main Ticket ---
    final Paint frontTicketPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFFBC02D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.015;

    canvas.save();
    canvas.translate(w * 0.5, h * 0.5);
    canvas.rotate(0.08); // Slight right tilt
    canvas.translate(-w * 0.32, -h * 0.22);

    final Rect frontRect = Rect.fromLTWH(0, 0, w * 0.64, h * 0.44);
    final RRect frontRRect = RRect.fromRectAndRadius(frontRect, Radius.circular(w * 0.04));
    
    // Draw ticket body
    canvas.drawRRect(frontRRect, frontTicketPaint);
    
    // Draw inner border lines (simulating ticket edges)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        frontRect.deflate(w * 0.03), 
        Radius.circular(w * 0.02),
      ), 
      borderPaint,
    );

    // --- 3. Draw the Center Cross Symbol (+) ---
    final Paint crossPaint = Paint()
      ..color = const Color(0xFF5D4037) // Dark brownish/black color from reference
      ..style = PaintingStyle.fill;

    final double cx = frontRect.width / 2;
    final double cy = frontRect.height / 2;
    final double thick = w * 0.05; // Thickness of the cross bars
    final double length = w * 0.14; // Length of the cross bars

    // Horizontal bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - length / 2, cy - thick / 2, length, thick),
        Radius.circular(thick / 2),
      ),
      crossPaint,
    );
    // Vertical bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - thick / 2, cy - length / 2, thick, length),
        Radius.circular(thick / 2),
      ),
      crossPaint,
    );

    canvas.restore();


    // --- 4. Draw Floating Sparkles (+) ---
    final Paint sparklePaint = Paint()
      ..color = const Color(0xFFFFE082)
      ..style = PaintingStyle.fill;

    // Helper method to draw a smaller sparkle cross at specific offsets
    void drawSparkle(double x, double y, double scale) {
      final double sThick = (w * 0.025) * scale;
      final double sLength = (w * 0.07) * scale;
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x - sLength / 2, y - sThick / 2, sLength, sThick), Radius.circular(sThick / 2)),
        sparklePaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x - sThick / 2, y - sLength / 2, sThick, sLength), Radius.circular(sThick / 2)),
        sparklePaint,
      );
    }

    // Position sparkles around the core ticket area
    drawSparkle(w * 0.45, h * 0.22, 1.1); // Top Center
    drawSparkle(w * 0.28, h * 0.35, 0.7); // Top Left
    drawSparkle(w * 0.68, h * 0.32, 0.8); // Top Right
    drawSparkle(w * 0.34, h * 0.72, 0.9); // Bottom Left
    drawSparkle(w * 0.65, h * 0.75, 0.7); // Bottom Right
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
