import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Which real-world screen class the preview should simulate.
enum ScreenView { mobile, tablet, web }

/// A device-shaped frame that runs [child]'s real Flutter widgets live,
/// sandboxed so it behaves like a device (spec: `docs/08-mobile-emulator-preview.md`, R6).
///
/// Isolation is via a nested [MaterialApp]:
/// * its own [Navigator] + [Overlay] — `Navigator.push`, bottom sheets and
///   dialogs from the demo stay **inside** the frame;
/// * its own [Theme] — a clean Material theme, so the site's `#af3a4a` doesn't
///   bleed into the preview;
/// * a `builder` that re-wraps everything in a device-sized [MediaQuery] — the
///   demo sees that device's metrics regardless of the real window.
///
/// [screenView] picks the simulated size:
/// * [ScreenView.mobile] — 390x844 phone, notch/home-indicator safe areas,
///   phone bezel. Keeps that portrait aspect ratio but scales to use as much
///   of the available space as it can — up *or* down, not capped at 1:1 —
///   so it isn't stuck tiny on a big screen just because 390x844 is small.
/// * [ScreenView.tablet] — 768x1024, thin outline frame, no notch insets.
///   Same scale-to-fit-either-way behavior, its own aspect ratio.
/// * [ScreenView.web] — no fixed size or bezel; fills all available space,
///   like a browser window. If that space shrinks below phone size (the
///   workspace toolbar/rail leave too little room), it scales down from a
///   phone-sized floor instead of squeezing the previewed page's own layout
///   past what it can render.
class DeviceFramePreview extends StatelessWidget {
  const DeviceFramePreview({
    super.key,
    required this.child,
    this.brightness = Brightness.light,
    this.screenView = ScreenView.mobile,
  });

  final Widget child;
  final Brightness brightness;
  final ScreenView screenView;

  static const Size _mobileSize = Size(390, 844);
  static const Size _tabletSize = Size(768, 1024);
  // Web has no fixed aspect ratio, so its "too small to render" floor can't
  // reuse the mobile phone's tall portrait size (390x844) — a normal browser
  // workspace is plenty wide but rarely that tall once header/toolbar chrome
  // is subtracted, which made the floor trigger on every ordinary window and
  // silently fall back to a scaled-down *phone*-shaped box instead of a wide
  // web-shaped one. This floor is a genuinely-too-small threshold instead.
  static const Size _webFloorSize = Size(320, 480);
  static const double _safeTop = 47;
  static const double _safeBottom = 34;
  static const double _bezel = 10;

  @override
  Widget build(BuildContext context) {
    final baseMediaQuery = MediaQuery.of(context);
    final isMobile = screenView == ScreenView.mobile;

    final safeTop = isMobile ? _safeTop : 0.0;
    final safeBottom = isMobile ? _safeBottom : 0.0;

    Widget buildScreen(Size size) => ClipRRect(
      borderRadius: BorderRadius.circular(
        isMobile ? AppRadius.device : AppRadius.sm,
      ),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: MediaQuery(
          data: baseMediaQuery.copyWith(
            size: size,
            devicePixelRatio: isMobile ? 3 : 2,
            padding: EdgeInsets.only(top: safeTop, bottom: safeBottom),
            viewPadding: EdgeInsets.only(top: safeTop, bottom: safeBottom),
            viewInsets: EdgeInsets.zero,
            textScaler: TextScaler.noScaling,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: brightness, useMaterial3: true),
            home: child,
            builder: (context, navigator) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: size,
                devicePixelRatio: isMobile ? 3 : 2,
                padding: EdgeInsets.only(top: safeTop, bottom: safeBottom),
                viewPadding: EdgeInsets.only(top: safeTop, bottom: safeBottom),
                textScaler: TextScaler.noScaling,
              ),
              child: navigator!,
            ),
          ),
        ),
      ),
    );

    if (screenView == ScreenView.web) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final available = constraints.biggest;
          final fitsFloor =
              available.width >= _webFloorSize.width &&
              available.height >= _webFloorSize.height;
          if (fitsFloor) return buildScreen(available);

          return FittedBox(
            fit: BoxFit.scaleDown,
            child: buildScreen(_webFloorSize),
          );
        },
      );
    }

    final targetSize = screenView == ScreenView.tablet
        ? _tabletSize
        : _mobileSize;
    final frameWidth = targetSize.width + (isMobile ? _bezel * 2 : 4);
    final frameHeight = targetSize.height + (isMobile ? _bezel * 2 : 4);

    // SizedBox.expand forces the FittedBox to claim the whole available
    // column (a plain FittedBox under loose constraints only ever sizes
    // itself down to its child's natural size, never up — so without this
    // it would silently ignore the "grow to fill" half of BoxFit.contain).
    return SizedBox.expand(
      child: FittedBox(
        // contain (not scaleDown): grow to fill the available column too,
        // not just shrink — the whole point of "get the available column
        // size", while still keeping the phone/tablet aspect ratio.
        fit: BoxFit.contain,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: frameWidth,
          height: frameHeight,
          padding: EdgeInsets.all(isMobile ? _bezel : 2),
          decoration: isMobile
              ? BoxDecoration(
                  color: AppColors.deviceBezel,
                  borderRadius: BorderRadius.circular(AppRadius.device + _bezel),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 40,
                      offset: Offset(0, 12),
                    ),
                  ],
                )
              : BoxDecoration(
                  border: Border.all(color: AppColors.deviceBezel, width: 2),
                  borderRadius: BorderRadius.circular(AppRadius.sm + 2),
                ),
          child: buildScreen(targetSize),
        ),
      ),
    );
  }
}
