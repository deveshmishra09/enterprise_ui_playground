import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/sub_flow.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Grid card for one subflow inside a flow detail screen (Slot 3a). Tapping
/// opens the editor at `/flows/<flowSlug>/<subSlug>` regardless of status.
class SubFlowCard extends StatelessWidget {
  const SubFlowCard({
    super.key,
    required this.flowSlug,
    required this.subFlow,
  });

  final String flowSlug;
  final SubFlow subFlow;

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
        onTap: () => context.push('/flows/$flowSlug/${subFlow.slug}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  subFlow.title,
                  style: AppText.h3(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _StatusChip(status: subFlow.status),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final SubFlowStatus status;

  @override
  Widget build(BuildContext context) {
    final isBuilt = status == SubFlowStatus.built;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: isBuilt ? AppColors.primarySoft : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        isBuilt ? 'Live' : 'Soon',
        style: AppText.eyebrow(context).copyWith(
          fontSize: 11,
          color: isBuilt ? AppColors.primary : scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
