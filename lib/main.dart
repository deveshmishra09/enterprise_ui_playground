import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clean path URLs (no `#`). Needs an SPA rewrite on the host — see
  // docs/10-deployment.md. No-op on non-web platforms.
  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ThemeScope(
      controller: ThemeController(prefs),
      child: const EnterpriseUiPlaygroundApp(),
    ),
  );
}
