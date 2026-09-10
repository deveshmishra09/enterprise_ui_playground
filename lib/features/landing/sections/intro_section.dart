import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/highlighted_text.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';

/// Slot 2 — Introduction. Two columns on desktop (text | animation), stacked on
/// tablet and phone. The animation column is an empty reserved box for now.
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

class _AnimationPlaceholder extends StatelessWidget {
  const _AnimationPlaceholder();

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
        child: Center(
          child: Text(
            'Animation',
            style: AppText.eyebrow(context).copyWith(color: AppColors.eyebrow),
          ),
        ),
      ),
    );
  }
}
