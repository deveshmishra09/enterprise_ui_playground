import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// A section title: an optional uppercase eyebrow above a large bold heading.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.eyebrow,
    this.align = TextAlign.start,
  });

  final String title;
  final String? eyebrow;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    final crossAxis = switch (align) {
      TextAlign.center => CrossAxisAlignment.center,
      TextAlign.end => CrossAxisAlignment.end,
      _ => CrossAxisAlignment.start,
    };

    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        if (eyebrow != null) ...[
          Text(
            eyebrow!,
            style: AppText.eyebrow(context).copyWith(color: AppColors.primary),
            textAlign: align,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(title, style: AppText.h1(context), textAlign: align),
      ],
    );
  }
}
