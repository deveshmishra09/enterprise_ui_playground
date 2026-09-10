import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_links.dart';
import '../constants/app_strings.dart';
import '../constants/breakpoints.dart';
import '../navigation/app_navigation.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'max_width_container.dart';

/// Slot 7. Three link columns + a centered copyright line. Columns sit in a row
/// on tablet/desktop and stack on phone.
class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      color: isDark ? AppColors.darkSurfaceMuted : AppColors.lightSurfaceMuted,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: MaxWidthContainer(
        child: Column(
          children: [
            _columns(context),
            const SizedBox(height: AppSpacing.xxl),
            const _Copyright(),
          ],
        ),
      ),
    );
  }

  Widget _columns(BuildContext context) {
    final columns = <Widget>[
      _FooterColumn(
        heading: AppStrings.footerProductHeading,
        links: [
          ('Flows', () => goToLandingSection(context, LandingSection.flows)),
          ('Pricing', () => goToLandingSection(context, LandingSection.pricing)),
          ('FAQ', () => goToLandingSection(context, LandingSection.faq)),
        ],
      ),
      _FooterColumn(
        heading: AppStrings.footerConnectHeading,
        links: [
          ('Support', () => context.go('/support')),
          ('Contact', () => context.go('/contact')),
          ('Follow on X', () => openExternalUrl(AppLinks.xUrl)),
        ],
      ),
      _FooterColumn(
        heading: AppStrings.footerLegalHeading,
        links: [
          ('Privacy', () => context.go('/privacy')),
          ('Terms', () => context.go('/terms')),
        ],
      ),
    ];

    if (context.isPhone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xl,
        children: columns,
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final column in columns) Expanded(child: column),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.heading, required this.links});

  final String heading;
  final List<(String label, VoidCallback onTap)> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: AppText.eyebrow(context).copyWith(color: AppColors.eyebrow),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final (label, onTap) in links)
          _FooterLink(label: label, onTap: onTap),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Text(
          label,
          style: AppText.bodySmall(context).copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _Copyright extends StatefulWidget {
  const _Copyright();

  @override
  State<_Copyright> createState() => _CopyrightState();
}

class _CopyrightState extends State<_Copyright> {
  late final TapGestureRecognizer _handleTap;

  @override
  void initState() {
    super.initState();
    _handleTap = TapGestureRecognizer()
      ..onTap = () => openExternalUrl(AppLinks.xUrl);
  }

  @override
  void dispose() {
    _handleTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = AppText.bodySmall(context).copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: AppStrings.footerCopyrightPrefix, style: base),
          TextSpan(
            text: AppStrings.footerCopyrightHandle,
            style: base.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
            recognizer: _handleTap,
          ),
          TextSpan(text: AppStrings.footerCopyrightSuffix, style: base),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
