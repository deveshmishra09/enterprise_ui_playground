import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/data/pricing_data.dart';
import 'package:enterprise_ui_playground/core/navigation/app_navigation.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';
import 'package:enterprise_ui_playground/core/widgets/pricing_card.dart';

/// Slot 4 — centered intro + Free / Plus cards. Cards sit in a row on desktop
/// and stack below 1024.
class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: MaxWidthContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.pricingEyebrow,
              style: AppText.eyebrow(context).copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppStrings.pricingStatement,
              textAlign: TextAlign.center,
              style: AppText.h2(context),
            ),
            const SizedBox(height: AppSpacing.sm),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                AppStrings.pricingSubline,
                textAlign: TextAlign.center,
                style: AppText.bodySmall(context).copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            _PlanCards(
              onFreeCta: () => goToLandingSection(context, LandingSection.flows),
              onPlusCta: () => context.go('/contact'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCards extends StatelessWidget {
  const _PlanCards({required this.onFreeCta, required this.onPlusCta});

  final VoidCallback onFreeCta;
  final VoidCallback onPlusCta;

  @override
  Widget build(BuildContext context) {
    final free = PricingCard(plan: kFreePlan, onCta: onFreeCta);
    final plus = PricingCard(plan: kPlusPlan, onCta: onPlusCta);

    if (context.isDesktop) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: free),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: plus),
          ],
        ),
      );
    }
    return Column(
      children: [
        free,
        const SizedBox(height: AppSpacing.lg),
        plus,
      ],
    );
  }
}
