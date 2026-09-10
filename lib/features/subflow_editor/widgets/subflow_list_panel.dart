import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:enterprise_ui_playground/core/models/app_flow.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';

/// The 20%-width left rail on the subflow editor (decision R5) — a vertical list
/// of every subflow in the flow. Tapping one deep-links to its editor URL.
class SubflowListPanel extends StatelessWidget {
  const SubflowListPanel({
    super.key,
    required this.flow,
    required this.activeSlug,
  });

  final AppFlow flow;
  final String activeSlug;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        itemCount: flow.subFlows.length,
        itemBuilder: (context, index) {
          final subFlow = flow.subFlows[index];
          final isActive = subFlow.slug == activeSlug;
          final scheme = Theme.of(context).colorScheme;

          return InkWell(
            onTap: isActive
                ? null
                : () => context.go('/flows/${flow.slug}/${subFlow.slug}'),
            child: Container(
              color: isActive ? AppColors.primarySoft : null,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      subFlow.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodySmall(context).copyWith(
                        color: isActive
                            ? AppColors.primary
                            : scheme.onSurface,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (subFlow.isBuilt) ...[
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Icons.circle, size: 6, color: AppColors.primary),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
