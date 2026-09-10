import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_strings.dart';
import '../constants/breakpoints.dart';
import '../navigation/app_navigation.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_logo.dart';
import 'theme_toggle_button.dart';

/// Slot 1. Two forms:
/// * [SiteHeaderVariant.defaultNav] — brand + Flows/Pricing/FAQ + actions.
/// * [SiteHeaderVariant.preview] — brand + centered "Preview" + actions
///   (used by the subflow editor).
enum SiteHeaderVariant { defaultNav, preview }

class SiteHeader extends StatelessWidget {
  const SiteHeader({super.key, this.variant = SiteHeaderVariant.defaultNav});

  final SiteHeaderVariant variant;

  /// Target width of the brand lock-up on desktop — the brief's "114mm"
  /// (~432 logical px, decision R7).
  static const double _brandSlotWidth = 432;

  @override
  Widget build(BuildContext context) {
    final height = context.isPhone ? 56.0 : 64.0;
    final isPreview = variant == SiteHeaderVariant.preview;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: context.outerGutter),
      child: context.isDesktop
          ? _DesktopBar(isPreview: isPreview, brandSlotWidth: _brandSlotWidth)
          : _CompactBar(isPreview: isPreview),
    );
  }
}

// --- Brand ---------------------------------------------------------------

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/'),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                AppStrings.siteName,
                overflow: TextOverflow.ellipsis,
                style: AppText.h3(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewLabel extends StatelessWidget {
  const _PreviewLabel();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.previewLabel,
      style: AppText.eyebrow(context).copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

// --- Actions -----------------------------------------------------------

class _ProfileButton extends StatelessWidget {
  const _ProfileButton();

  @override
  Widget build(BuildContext context) {
    // Decorative this milestone — no menu, no link (decision R9).
    return IconButton(
      tooltip: 'Profile',
      onPressed: () {},
      icon: const Icon(Icons.person_outline),
    );
  }
}

// --- Desktop layout --------------------------------------------------

class _DesktopBar extends StatelessWidget {
  const _DesktopBar({required this.isPreview, required this.brandSlotWidth});

  final bool isPreview;
  final double brandSlotWidth;

  @override
  Widget build(BuildContext context) {
    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: const [ThemeToggleButton(), _ProfileButton()],
    );

    if (isPreview) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: brandSlotWidth, child: const _Brand()),
              const Spacer(),
              actions,
            ],
          ),
          const IgnorePointer(child: _PreviewLabel()),
        ],
      );
    }

    return Row(
      children: [
        SizedBox(width: brandSlotWidth, child: const _Brand()),
        const _NavLinks(),
        const Spacer(),
        actions,
      ],
    );
  }
}

class _NavLinks extends StatelessWidget {
  const _NavLinks();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xs,
      children: [
        for (final section in LandingSection.values)
          _NavLink(
            label: _sectionLabel(section),
            onTap: () => goToLandingSection(context, section),
          ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        textStyle: AppText.button(context),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      child: Text(label),
    );
  }
}

// --- Compact (tablet / phone) layout -------------------------------

class _CompactBar extends StatelessWidget {
  const _CompactBar({required this.isPreview});

  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    if (isPreview) {
      return Stack(
        alignment: Alignment.center,
        children: const [
          Row(
            children: [
              Expanded(child: _Brand()),
              ThemeToggleButton(),
            ],
          ),
          IgnorePointer(child: _PreviewLabel()),
        ],
      );
    }

    return Row(
      children: [
        const Expanded(child: _Brand()),
        const ThemeToggleButton(),
        if (!context.isPhone) const _ProfileButton(),
        const _NavMenuButton(),
      ],
    );
  }
}

class _NavMenuButton extends StatelessWidget {
  const _NavMenuButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LandingSection>(
      tooltip: 'Menu',
      icon: const Icon(Icons.menu),
      onSelected: (section) => goToLandingSection(context, section),
      itemBuilder: (context) => [
        for (final section in LandingSection.values)
          PopupMenuItem<LandingSection>(
            value: section,
            child: Text(_sectionLabel(section)),
          ),
      ],
    );
  }
}

String _sectionLabel(LandingSection section) => switch (section) {
  LandingSection.flows => 'Flows',
  LandingSection.pricing => 'Pricing',
  LandingSection.faq => 'FAQ',
};
