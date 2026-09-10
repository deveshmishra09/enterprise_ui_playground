import 'package:flutter/material.dart';

import '../models/pricing_plan.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Slot 4 plan card. `free` is transparent/outlined; `plus` is a solid
/// primary-colored card with white foreground.
class PricingCard extends StatelessWidget {
  const PricingCard({super.key, required this.plan, this.onCta});

  final PricingPlan plan;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final isPlus = plan.variant == PricingVariant.plus;
    final scheme = Theme.of(context).colorScheme;

    final fg = isPlus ? AppColors.onPrimary : scheme.onSurface;
    final fgMuted = isPlus
        ? AppColors.onPrimary.withValues(alpha: 0.82)
        : scheme.onSurfaceVariant;
    final accent = isPlus ? AppColors.onPrimary : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: isPlus ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: isPlus
            ? null
            : Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            plan.name,
            style: AppText.eyebrow(context).copyWith(color: accent),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(plan.priceLabel, style: AppText.h1(context).copyWith(color: fg)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                plan.cadenceLabel,
                style: AppText.bodySmall(context).copyWith(color: fgMuted),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            plan.tagline,
            style: AppText.body(context).copyWith(color: fgMuted),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final feature in plan.features)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 18, color: accent),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppText.bodySmall(context).copyWith(color: fg),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: isPlus
                ? FilledButton(
                    onPressed: onCta,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.onPrimary,
                      foregroundColor: AppColors.primary,
                    ),
                    child: Text(plan.ctaLabel),
                  )
                : OutlinedButton(
                    onPressed: onCta,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.onSurface,
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    child: Text(plan.ctaLabel),
                  ),
          ),
        ],
      ),
    );
  }
}
