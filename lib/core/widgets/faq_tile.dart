import 'package:flutter/material.dart';

import '../models/faq_item.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// One FAQ row (Slot 5). The parent owns the open/closed state so only one tile
/// is expanded at a time.
class FaqTile extends StatelessWidget {
  const FaqTile({
    super.key,
    required this.item,
    required this.isOpen,
    required this.onTap,
  });

  final FaqItem item;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Text(item.question, style: AppText.h3(context)),
                ),
                const SizedBox(width: AppSpacing.md),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Text(
              item.answer,
              style: AppText.body(context).copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
          sizeCurve: Curves.easeInOutCubic,
        ),
      ],
    );
  }
}
