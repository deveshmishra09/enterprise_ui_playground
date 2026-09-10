import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/theme/app_theme.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/router/app_router.dart';

/// Root widget. Owns the [GoRouter] instance and reads the current [ThemeMode]
/// from the nearest [ThemeScope] (set up in `main.dart`).
class EnterpriseUiPlaygroundApp extends StatefulWidget {
  const EnterpriseUiPlaygroundApp({super.key});

  @override
  State<EnterpriseUiPlaygroundApp> createState() =>
      _EnterpriseUiPlaygroundAppState();
}

class _EnterpriseUiPlaygroundAppState extends State<EnterpriseUiPlaygroundApp> {
  final GoRouter _router = createAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ThemeScope.of(context);
    return MaterialApp.router(
      title: AppStrings.siteName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: controller.mode,
      routerConfig: _router,
    );
  }
}
