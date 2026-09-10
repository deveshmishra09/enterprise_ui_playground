import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A phone-shaped frame that runs [child]'s real Flutter widgets live, sandboxed
/// so it behaves like a device (spec: `docs/08-mobile-emulator-preview.md`, R6).
///
/// Isolation is via a nested [MaterialApp]:
/// * its own [Navigator] + [Overlay] — `Navigator.push`, bottom sheets and
///   dialogs from the demo stay **inside** the frame;
/// * its own [Theme] — a clean Material theme, so the site's `#af3a4a` doesn't
///   bleed into the preview;
/// * a `builder` that re-wraps everything in a phone-sized [MediaQuery] — the
///   demo sees phone metrics regardless of the real window.
///
/// The frame renders at a fixed logical size and scales **down** to fit; it
/// never enlarges past 1:1.
class DeviceFramePreview extends StatelessWidget {
  const DeviceFramePreview({
    super.key,
    required this.child,
    this.brightness = Brightness.light,
  });

  final Widget child;
  final Brightness brightness;

  static const Size _screenSize = Size(390, 844);
  static const double _safeTop = 47;
  static const double _safeBottom = 34;
  static const double _bezel = 10;

  @override
  Widget build(BuildContext context) {
    final baseMediaQuery = MediaQuery.of(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.all(_bezel),
        decoration: BoxDecoration(
          color: AppColors.deviceBezel,
          borderRadius: BorderRadius.circular(AppRadius.device + _bezel),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 40,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.device),
          child: SizedBox(
            width: _screenSize.width,
            height: _screenSize.height,
            child: MediaQuery(
              data: baseMediaQuery.copyWith(
                size: _screenSize,
                devicePixelRatio: 3,
                padding: const EdgeInsets.only(
                  top: _safeTop,
                  bottom: _safeBottom,
                ),
                viewPadding: const EdgeInsets.only(
                  top: _safeTop,
                  bottom: _safeBottom,
                ),
                viewInsets: EdgeInsets.zero,
                textScaler: TextScaler.noScaling,
              ),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(brightness: brightness, useMaterial3: true),
                home: child,
                builder: (context, navigator) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    size: _screenSize,
                    devicePixelRatio: 3,
                    padding: const EdgeInsets.only(
                      top: _safeTop,
                      bottom: _safeBottom,
                    ),
                    viewPadding: const EdgeInsets.only(
                      top: _safeTop,
                      bottom: _safeBottom,
                    ),
                    textScaler: TextScaler.noScaling,
                  ),
                  child: navigator!,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
