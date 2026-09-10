import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/constants/app_links.dart';
import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/navigation/app_navigation.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/info_page_scaffold.dart';

/// Route `/contact` — "Get in touch". Reached from the Slot 6 CTA and the footer.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoPageScaffold(
      eyebrow: AppStrings.contactEyebrow,
      title: AppStrings.contactHeading,
      intro: AppStrings.contactBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ContactRow(
            label: AppStrings.contactEmailLabel,
            value: AppLinks.contactEmail,
            onTap: () => openExternalUrl(AppLinks.mailto),
          ),
          const Divider(height: 1),
          _ContactRow(
            label: AppStrings.contactFollowLabel,
            value: AppLinks.xHandle,
            onTap: () => openExternalUrl(AppLinks.xUrl),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(
      label,
      style: AppText.eyebrow(context).copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
    final valueWidget = InkWell(
      onTap: onTap,
      child: Text(
        value,
        style: AppText.body(context).copyWith(color: AppColors.primary),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: context.isPhone
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelWidget,
                const SizedBox(height: AppSpacing.xs),
                valueWidget,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [labelWidget, valueWidget],
            ),
    );
  }
}
