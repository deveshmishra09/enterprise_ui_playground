import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Shown inside the device frame for subflows that don't have a demo yet.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({
    super.key,
    required this.flowTitle,
    required this.subFlowTitle,
  });

  final String flowTitle;
  final String subFlowTitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.hourglass_empty,
                size: 40,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(AppStrings.comingSoonLabel, style: AppText.h3(context)),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$flowTitle · $subFlowTitle',
                textAlign: TextAlign.center,
                style: AppText.bodySmall(context).copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
