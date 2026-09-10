import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/app_flow.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Grid card for one of the six flows (Slot 3). Tapping opens
/// `/flows/<slug>`.
class FlowCard extends StatelessWidget {
  const FlowCard({super.key, required this.flow});

  final AppFlow flow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        onTap: () => context.go('/flows/${flow.slug}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(flow.icon, size: 28, color: AppColors.primary),
              const Spacer(),
              Text(flow.title, style: AppText.h3(context)),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${flow.count} subflows',
                style: AppText.bodySmall(context).copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
