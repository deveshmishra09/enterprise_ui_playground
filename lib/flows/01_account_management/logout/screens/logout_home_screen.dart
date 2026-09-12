import 'package:flutter/material.dart';

class LogoutHomeScreen extends StatefulWidget {
  final bool showInboxAnimation;

  const LogoutHomeScreen({
    super.key,
    this.showInboxAnimation = false,
  });

  @override
  State<LogoutHomeScreen> createState() => _LogoutHomeScreenState();
}

class _LogoutHomeScreenState extends State<LogoutHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    if (widget.showInboxAnimation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward();

        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            _animationController.reverse();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/flows/01_account_management/login/assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 80.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yours.\nOn the move.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Never miss out on what you love. \nAll in the one app.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {},
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      'Continue as Guest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (widget.showInboxAnimation)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.40,
              left: 0,
              right: 0,
              child: Center(
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeOut,
                  ),
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeOutBack,
                    ),
                    child: Container(
                      width: 190,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4E8),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.20),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return CustomPaint(
                                size: const Size(32, 32),
                                painter: CheckPainter(
                                  progress: _animationController.value,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Check your inbox!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CheckPainter extends CustomPainter {
  final double progress;

  CheckPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(
      size.width * 0.20,
      size.height * 0.52,
    );

    path.lineTo(
      size.width * 0.43,
      size.height * 0.75,
    );

    path.lineTo(
      size.width * 0.82,
      size.height * 0.28,
    );

    final pathMetrics = path.computeMetrics().toList();

    if (pathMetrics.isNotEmpty) {
      final metric = pathMetrics.first;

      final animatedPath = metric.extractPath(
        0,
        metric.length * progress,
      );

      canvas.drawPath(
        animatedPath,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CheckPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}