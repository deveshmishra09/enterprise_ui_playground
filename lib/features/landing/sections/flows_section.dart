import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/widgets/flow_card.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';
import 'package:enterprise_ui_playground/core/widgets/section_heading.dart';

/// Slot 3 — "Explore the flows" heading + a responsive grid of the six flows.
class FlowsSection extends StatelessWidget {
  const FlowsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: MaxWidthContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeading(title: AppStrings.flowsHeading),
            const SizedBox(height: AppSpacing.xl),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kAllFlows.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.gridColumns,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: context.responsive(
                  phone: 1.9,
                  tablet: 1.5,
                  desktop: 1.35,
                ),
              ),
              itemBuilder: (context, index) => FlowCard(flow: kAllFlows[index]),
            ),
          ],
        ),
      ),
    );
  }
}
