import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanningHomeScreen extends StatefulWidget {
  const ScanningHomeScreen({super.key});

  @override
  State<ScanningHomeScreen> createState() => _ScanningHomeScreenState();
}

// Added SingleTickerProviderStateMixin to handle the custom animation controller smoothly
class _ScanningHomeScreenState extends State<ScanningHomeScreen>
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
                    tag: 'scanning_button',
                    // Material wrapper ensures custom splash/ripple effects from InkWell don't clip raw shapes
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          final String? scannedValue =
                              await Navigator.of(context).push<String>(
                                MaterialPageRoute<String>(
                                  builder: (_) => const _QrScannerScreen(),
                                ),
                              );

                          if (!context.mounted || scannedValue == null) return;
                          await _openScannedUrl(scannedValue);
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
                                      Icons.qr_code_scanner,
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
                                      'Scanning',
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

  Future<void> _openScannedUrl(String value) async {
    final Uri? uri = Uri.tryParse(value.trim());
    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
      _showScanMessage('This QR code does not contain a valid website link.');
      return;
    }

    final bool opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!opened && mounted) {
      _showScanMessage('Could not open the website.');
    }
  }

  void _showScanMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _QrScannerScreen extends StatefulWidget {
  const _QrScannerScreen();

  @override
  State<_QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<_QrScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController(
    autoStart: true,
    facing: CameraFacing.back,
    formats: <BarcodeFormat>[BarcodeFormat.qrCode],
  );
  bool _hasScanned = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _handleDetection(BarcodeCapture capture) {
    if (_hasScanned) return;

    for (final barcode in capture.barcodes) {
      final String? value = barcode.rawValue;
      if (value == null || value.isEmpty) continue;

      _hasScanned = true;
      Navigator.of(context).pop(value);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan QR code'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _handleDetection,
            errorBuilder: (context, error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Unable to access the camera.\n'
                        '${error.errorDetails?.message ?? error.errorCode.name}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        _scannerController.start();
                      },
                      child: const Text('Try camera again'),
                    ),
                  ],
                ),
              );
            },
          ),
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const Positioned(
            left: 24,
            right: 24,
            bottom: 32,
            child: Text(
              'Point your camera at a QR code',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
