import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/highlighted_text.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';

/// Slot 2 — Introduction. Two columns on desktop (text | animation), stacked on
/// tablet and phone. The animation column previews the app's own core feature:
/// a device frame that morphs between Mobile/Tablet/Web widths (see
/// `DeviceFramePreview`/`ScreenView`), so a visitor sees what this tool does
/// before ever opening a flow.
class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: MaxWidthContainer(
        child: context.isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(child: _IntroText()),
                  SizedBox(width: AppSpacing.xxl),
                  Expanded(child: _AnimationPlaceholder()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _IntroText(),
                  SizedBox(height: AppSpacing.xl),
                  _AnimationPlaceholder(),
                ],
              ),
      ),
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.introEyebrow,
          style: AppText.eyebrow(context).copyWith(color: AppColors.eyebrow),
        ),
        const SizedBox(height: AppSpacing.md),
        HighlightedText(
          text: AppStrings.introHeadlinePrefix + AppStrings.introHeadlineAccent,
          highlight: AppStrings.introHeadlineAccent,
          style: AppText.display(context),
        ),
      ],
    );
  }
}

/// The three simulated widths this loops through, as a fraction of the box's
/// own width — echoes the real Mobile/Tablet/Web ratio from
/// `DeviceFramePreview` (390/768/1440-ish) without depending on it directly.
enum _PreviewMode {
  mobile(Icons.smartphone, 0.34),
  tablet(Icons.tablet_mac, 0.62),
  web(Icons.language, 1.0);

  const _PreviewMode(this.icon, this.widthFraction);

  final IconData icon;
  final double widthFraction;
}

class _AnimationPlaceholder extends StatefulWidget {
  const _AnimationPlaceholder();

  @override
  State<_AnimationPlaceholder> createState() => _AnimationPlaceholderState();
}

class _AnimationPlaceholderState extends State<_AnimationPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _widthFraction;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    );
    // A perpetually-repeating controller never goes idle, which is exactly
    // what `WidgetTester.pumpAndSettle` (used throughout this app's widget
    // tests) waits for — so it hangs on every test that mounts the landing
    // page. Respecting reduce-motion also happens to fix that: tests run
    // with `disableAnimations` forced true (see test/flutter_test_config.dart),
    // same signal a real visitor's OS-level "reduce motion" setting sends.
    final reduceMotion =
        WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations;
    if (!reduceMotion) _controller.repeat();

    // Hold at each device width, ease into the next — mobile -> tablet ->
    // web -> back to mobile — rather than a constant sweep, so each size
    // reads as a deliberate stop, not just a pulsing box.
    _widthFraction = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween(_PreviewMode.mobile.widthFraction),
        weight: 18,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _PreviewMode.mobile.widthFraction,
          end: _PreviewMode.tablet.widthFraction,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: ConstantTween(_PreviewMode.tablet.widthFraction),
        weight: 18,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _PreviewMode.tablet.widthFraction,
          end: _PreviewMode.web.widthFraction,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: ConstantTween(_PreviewMode.web.widthFraction),
        weight: 18,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _PreviewMode.web.widthFraction,
          end: _PreviewMode.mobile.widthFraction,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 15,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _PreviewMode _activeMode(double fraction) {
    final midMobileTablet =
        (_PreviewMode.mobile.widthFraction + _PreviewMode.tablet.widthFraction) / 2;
    final midTabletWeb =
        (_PreviewMode.tablet.widthFraction + _PreviewMode.web.widthFraction) / 2;
    if (fraction < midMobileTablet) return _PreviewMode.mobile;
    if (fraction < midTabletWeb) return _PreviewMode.tablet;
    return _PreviewMode.web;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 11,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.mutedSurfaceFor(Theme.of(context).brightness),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final fraction = _widthFraction.value;
              return Column(
                children: [
                  _ModeRow(active: _activeMode(fraction)),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: fraction,
                        heightFactor: 1,
                        child: const _MockDeviceScreen(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Mirrors the real Mobile/Tablet/Web toggle from the subflow editor
/// (`_ScreenViewToggle`), so the highlight sliding between icons here reads
/// as the same control, not a made-up one.
class _ModeRow extends StatelessWidget {
  const _ModeRow({required this.active});

  final _PreviewMode active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final mode in _PreviewMode.values) ...[
          if (mode != _PreviewMode.values.first)
            const SizedBox(width: AppSpacing.sm),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: mode == active ? AppColors.primarySoft : null,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              mode.icon,
              size: 16,
              color: mode == active
                  ? AppColors.primary
                  : AppColors.eyebrow,
            ),
          ),
        ],
      ],
    );
  }
}

/// A generic "app screen" skeleton — header + text lines + a CTA bar — inside
/// a device bezel, standing in for any of the real flow demos this tool
/// previews. Only the frame's width changes; this content just reflows with
/// it, same as a real page would.
class _MockDeviceScreen extends StatelessWidget {
  const _MockDeviceScreen();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.deviceBezel,
        borderRadius: BorderRadius.circular(AppRadius.md + 4),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        // This mock's own content has a fixed natural height (icon + lines +
        // button), but the bezel around it can end up shorter than that —
        // e.g. this whole animation rendered inside an actual phone-width
        // viewport. Scaling the fixed-width content down as one block (never
        // up: `scaleDown`) keeps it fully visible instead of overflowing.
        child: LayoutBuilder(
          builder: (context, constraints) => FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppColors.primarySoft,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Expanded(
                        child: _SkeletonBar(widthFactor: 0.35, height: 8),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _SkeletonBar(widthFactor: 1, height: 10),
                  const SizedBox(height: AppSpacing.sm),
                  const _SkeletonBar(widthFactor: 0.82, height: 10),
                  const SizedBox(height: AppSpacing.sm),
                  const _SkeletonBar(widthFactor: 0.55, height: 10),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({required this.widthFactor, required this.height});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkOutline : AppColors.lightOutline,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
