import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// A stack of heading + body paragraphs, used for the Support / Privacy / Terms
/// page bodies.
class ProseSections extends StatelessWidget {
  const ProseSections({super.key, required this.sections});

  /// `(heading, body)` pairs, in order.
  final List<(String heading, String body)> sections;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (heading, body) in sections)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(heading, style: AppText.h3(context)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  body,
                  style: AppText.body(context).copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
