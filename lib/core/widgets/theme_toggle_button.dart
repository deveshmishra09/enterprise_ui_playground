import 'package:flutter/material.dart';

import '../theme/theme_controller.dart';

/// Header button that flips between light and dark. Default is light; the choice
/// is persisted by [ThemeController].
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeScope.of(context);
    return IconButton(
      tooltip: controller.isDark ? 'Switch to light theme' : 'Switch to dark theme',
      onPressed: controller.toggle,
      icon: Icon(
        controller.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      ),
    );
  }
}
