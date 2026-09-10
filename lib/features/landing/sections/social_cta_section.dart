import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/max_width_container.dart';

/// Slot 6 — one centered line with a primary-colored "Get in touch" button that
/// opens `/contact`.
class SocialCtaSection extends StatelessWidget {
  const SocialCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionGap),
      child: MaxWidthContainer(
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(AppStrings.socialCtaPrefix, style: AppText.h3(context)),
              InkWell(
                onTap: () => context.go('/contact'),
                child: Text(
                  AppStrings.socialCtaAction,
                  style: AppText.h3(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
