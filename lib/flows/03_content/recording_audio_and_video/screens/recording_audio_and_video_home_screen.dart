import 'package:enterprise_ui_playground/flows/03_content/recording_audio_and_video/screens/recording_audio_and_video.dart';
import 'package:flutter/material.dart';

class RecordingAudioAndVideoHomeScreen extends StatefulWidget {
  const RecordingAudioAndVideoHomeScreen({super.key});

  @override
  State<RecordingAudioAndVideoHomeScreen> createState() =>
      _RecordingAudioAndVideoHomeScreenState();
}

// Added SingleTickerProviderStateMixin to handle the custom animation controller smoothly
class _RecordingAudioAndVideoHomeScreenState
    extends State<RecordingAudioAndVideoHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Creates a continuous breathing rhythm loop lasting 2 seconds
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Animates the scale size up to 1.08x back and forth smoothly
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            // Background Image covering the full screen correctly
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: ScaleTransition(
                  scale: _pulseAnimation,
                  child: Hero(
                    tag: 'recording_audio_and_video',
                    // Material wrapper ensures custom splash/ripple effects from InkWell don't clip raw shapes
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RecordingAudioAndVideo(),
                            ),
                          );
                        },
                        customBorder: const CircleBorder(),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 1. Ambient outer neon glow aura reflecting the blue vectors on the backdrop
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF67929E,
                                    ).withOpacity(0.35),
                                    blurRadius: 40,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            // 2. High-fidelity glassmorphic multi-gradient interaction body element
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // Gradient transitioning from your base brand tone into a deeper tech shade
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF67929E),
                                    Color(0xFF3E606B),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Visual Icon Indicator
                                    Icon(
                                      Icons.videocam,
                                      size: 44,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 12),
                                    // Primary Call-To-Action Heading Text
                                    Text(
                                      'TAP TO START',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Clear Subtitle description
                                    Text(
                                      'Audio and Video Recording',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
