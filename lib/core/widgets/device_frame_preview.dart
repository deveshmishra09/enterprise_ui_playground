import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

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
/// [screenView] picks the simulated size. Each view keeps its real size and
/// aspect ratio but scales to use as much of the available space as it can —
/// up *or* down, not capped at 1:1 — so it isn't stuck tiny on a big screen:
/// * [ScreenView.mobile] — 390x844 phone, notch/home-indicator safe areas,
///   phone bezel.
/// * [ScreenView.tablet] — 768x1024, thin outline frame, no notch insets.
/// * [ScreenView.web] — a 1440x900 desktop browser viewport under a browser
///   toolbar (window dots + address bar), in the same thin outline frame.
///
/// All three views share one widget tree — only sizes and decorations change
/// — so switching views resizes the running demo in place. A structural
/// change would remount the nested [MaterialApp] and restart the demo.
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
  static const Size _webSize = Size(1440, 900);
  static const double _safeTop = 47;
  static const double _safeBottom = 34;
  static const double _bezel = 10;
  static const double _browserToolbarHeight = 52;
  static const Duration _resizeDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final baseMediaQuery = MediaQuery.of(context);
    final isMobile = screenView == ScreenView.mobile;
    final isWeb = screenView == ScreenView.web;

    final safeTop = isMobile ? _safeTop : 0.0;
    final safeBottom = isMobile ? _safeBottom : 0.0;
    final screenRadius = Radius.circular(
      isMobile ? AppRadius.device : AppRadius.sm,
    );

    Widget buildScreen(Size size) => ClipRRect(
      // Square top corners under the browser toolbar, like a real window.
      borderRadius: BorderRadius.vertical(
        top: isWeb ? Radius.zero : screenRadius,
        bottom: screenRadius,
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

    final targetSize = switch (screenView) {
      ScreenView.mobile => _mobileSize,
      ScreenView.tablet => _tabletSize,
      ScreenView.web => _webSize,
    };
    final toolbarHeight = isWeb ? _browserToolbarHeight : 0.0;
    final frameWidth = targetSize.width + (isMobile ? _bezel * 2 : 4);
    final frameHeight =
        targetSize.height + toolbarHeight + (isMobile ? _bezel * 2 : 4);

    // SizedBox.expand forces the FittedBox to claim the whole available
    // column (a plain FittedBox under loose constraints only ever sizes
    // itself down to its child's natural size, never up — so without this
    // it would silently ignore the "grow to fill" half of BoxFit.contain).
    return SizedBox.expand(
      child: FittedBox(
        // contain (not scaleDown): grow to fill the available column too,
        // not just shrink — the whole point of "get the available column
        // size", while still keeping each view's aspect ratio.
        fit: BoxFit.contain,
        child: AnimatedContainer(
          duration: _resizeDuration,
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
          child: Column(
            children: [
              // Always in the tree (zero height unless web): adding/removing it
              // would change the structure above the demo and remount it.
              AnimatedContainer(
                duration: _resizeDuration,
                curve: Curves.easeOutCubic,
                height: toolbarHeight,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: AppColors.browserToolbar,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.sm),
                  ),
                ),
                child: const OverflowBox(
                  alignment: Alignment.topCenter,
                  minHeight: _browserToolbarHeight,
                  maxHeight: _browserToolbarHeight,
                  child: _BrowserToolbar(),
                ),
              ),
              Expanded(child: buildScreen(targetSize)),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Web view's browser toolbar: window dots and a centered address bar.
class _BrowserToolbar extends StatelessWidget {
  const _BrowserToolbar();

  static const double _dotSize = 12;

  @override
  Widget build(BuildContext context) {
    const dots = [
      AppColors.browserDotClose,
      AppColors.browserDotMinimize,
      AppColors.browserDotZoom,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          for (final color in dots)
            Container(
              width: _dotSize,
              height: _dotSize,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          Expanded(
            child: Center(
              child: Container(
                height: 32,
                constraints: const BoxConstraints(maxWidth: 560),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.xs,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: AppColors.lightTextSecondary,
                    ),
                    Text(
                      'yourapp.com',
                      style: AppText.bodySmall(
                        context,
                      ).copyWith(color: AppColors.lightTextSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Same width as the dots, so the address bar sits truly centered.
          SizedBox(width: (_dotSize + AppSpacing.sm) * dots.length),
        ],
      ),
    );
  }
}
