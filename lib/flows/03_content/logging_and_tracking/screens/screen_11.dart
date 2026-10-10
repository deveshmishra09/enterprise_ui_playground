import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/logging_and_tracking_home_screen.dart';
import 'package:flutter/material.dart';

class Screen11 extends StatefulWidget {
  const Screen11({super.key});

  @override
  State<Screen11> createState() => _Screen11State();
}

class _Screen11State extends State<Screen11> {
  // Mock data for completed milestone checklists
  final List<String> milestones = [
    'Daily Reflection Completed',
    'First Journaling\nPrompt Answered',
    'First Daily Focus Selected',
    'First Sleep Metric Added',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF7F7F9,
      ), // Subtle clean off-white background matching the image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),

              // 1. Central Petal/Flower Motif Streak Logo Illustration
              WidgetAnimator(
                child: CustomPaint(
                  size: const Size(90, 90),
                  painter: PetalLogoPainter(),
                ),
              ),
              const SizedBox(height: 36),

              // 2. Sub-header tracking text with letter-spacing applied
              const Text(
                '1 DAY STREAK',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 12),

              // 3. RichText to display embedded inline graphics seamlessly
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Good job! You are ready and can\nfocus on ',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.home_outlined,
                          size: 18,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const TextSpan(text: 'Family and '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          size: 18,
                          color: Colors.black.withOpacity(0.8),
                        ), // Alternate for Crown/Self-Care
                      ),
                    ),
                    const TextSpan(text: 'Self-care'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 4. Centered Alignment Checklist Block Container
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: milestones.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, right: 12.0),
                          child: Icon(
                            Icons.check_rounded,
                            size: 15,
                            color: Colors.black87,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const Spacer(flex: 2),

              // 5. Footer Sign-off Label
              const Text(
                'See you tomorrow!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // 6. Action Submission Stadium Call-To-Action Element
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(220, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoggingAndTrackingHomeScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Keep exploring stoic.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter to structurally render the minimalist flower motif artwork from your screenshot canvas
class PetalLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint activePaint = Paint()..color = Colors.black;
    final Paint inactivePaint = Paint()..color = Colors.black.withOpacity(0.15);
    final center = Offset(size.width / 2, size.height / 2);
    const int petalCount = 8;

    for (int i = 0; i < petalCount; i++) {
      final double angle = (i * 2 * 3.14159 / petalCount) - (3.14159 / 2);
      canvas.save();
      canvas.translate(center.dx, center.centerExtent);
      canvas.rotate(angle);
      canvas.translate(0, -22);

      final Path petalPath = Path();
      petalPath.moveTo(0, -12);
      petalPath.quadraticBezierTo(7, -3, 0, 8);
      petalPath.quadraticBezierTo(-7, -3, 0, -12);
      petalPath.close();

      // Top vertical petal is distinctly highlighted black; remainder elements are transparent gray accents
      canvas.drawPath(petalPath, i == 0 ? activePaint : inactivePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Micro animation enhancement to gently fade layout features cleanly upon entry transition sequences
class WidgetAnimator extends StatelessWidget {
  final Widget child;
  const WidgetAnimator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: child,
    );
  }
}

extension on Offset {
  double get centerExtent => dy;
}
