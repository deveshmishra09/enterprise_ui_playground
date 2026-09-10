import 'package:flutter/material.dart';

import '../constants/breakpoints.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_logo.dart';
import 'page_scaffold.dart';

/// Shared shell for the Contact / Support / Privacy / Terms pages: standard
/// header + footer, a dark hero band (decision R8) with a centered logo, an
/// eyebrow, a white title and an intro line, a divider, then the page body
/// constrained to a readable column.
class InfoPageScaffold extends StatelessWidget {
  const InfoPageScaffold({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.intro,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String intro;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Hero(eyebrow: eyebrow, title: title, intro: intro),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.outerGutter,
              vertical: AppSpacing.xxl,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(height: 1),
                    const SizedBox(height: AppSpacing.xl),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.eyebrow, required this.title, required this.intro});

  final String eyebrow;
  final String title;
  final String intro;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.inkBand,
      padding: EdgeInsets.only(
        left: context.outerGutter,
        right: context.outerGutter,
        top: AppSpacing.xxl + AppSpacing.md,
        bottom: AppSpacing.xxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo(size: 48)),
              const SizedBox(height: AppSpacing.lg),
              Text(
                eyebrow,
                style: AppText.eyebrow(context).copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                style: AppText.h1(context).copyWith(color: AppColors.onPrimary),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                intro,
                style: AppText.bodySmall(context).copyWith(
                  color: AppColors.inkBandText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
