import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/models/app_flow.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/app_logo.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';
import 'package:enterprise_ui_playground/core/widgets/page_scaffold.dart';
import 'package:enterprise_ui_playground/core/widgets/sub_flow_card.dart';

/// Slot 3a — route `/flows/:flowSlug`. Centered logo + flow title + a responsive
/// grid of the flow's subflows, inside the standard shell.
class FlowDetailPage extends StatelessWidget {
  const FlowDetailPage({super.key, required this.flow});

  final AppFlow flow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return PageScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.sectionGap),
        child: MaxWidthContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo(size: 44)),
              const SizedBox(height: AppSpacing.lg),
              Text(
                flow.title,
                style: AppText.h1(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${flow.count} subflows',
                style: AppText.bodySmall(context).copyWith(
                  color: scheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: flow.subFlows.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridColumns,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: context.responsive(
                    phone: 3.0,
                    tablet: 2.3,
                    desktop: 2.4,
                  ),
                ),
                itemBuilder: (context, index) => SubFlowCard(
                  flowSlug: flow.slug,
                  subFlow: flow.subFlows[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
