import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/data/faq_data.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/widgets/faq_tile.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';
import 'package:enterprise_ui_playground/core/widgets/section_heading.dart';

/// Slot 5 — centered heading + an accordion of FAQ rows separated by dividers.
/// One row open at a time.
class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _openIndex;

  void _toggle(int index) {
    setState(() => _openIndex = _openIndex == index ? null : index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: MaxWidthContainer(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeading(
                  title: AppStrings.faqHeading,
                  align: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                const Divider(height: 1),
                for (var i = 0; i < kFaqItems.length; i++) ...[
                  FaqTile(
                    item: kFaqItems[i],
                    isOpen: _openIndex == i,
                    onTap: () => _toggle(i),
                  ),
                  const Divider(height: 1),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
