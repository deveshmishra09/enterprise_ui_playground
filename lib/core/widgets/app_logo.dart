import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// The brand mark: the "DM" logo on a white rounded tile so it reads the same in
/// light and dark themes and on the dark hero band (Contact / legal pages).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 28});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}
