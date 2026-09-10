import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';

/// Routes built entirely from our own widgets. The subflow editor with a *built*
/// demo is excluded — several legacy demo screens have known latent overflows at
/// phone width (docs/09 Phase 4).
const _routes = <String>[
  '/',
  '/flows/content',
  '/flows/content/drawing', // editor, coming-soon (no legacy demo mounted)
  '/contact',
  '/support',
  '/privacy',
  '/terms',
];

const _sizes = <Size>[
  Size(360, 800), // small phone
  Size(768, 1024), // tablet
  Size(1440, 1000), // desktop
];

Future<void> _run(WidgetTester tester, {required bool dark}) async {
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  SharedPreferences.setMockInitialValues(
    dark ? <String, Object>{'theme_mode': 'dark'} : <String, Object>{},
  );
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ThemeScope(
      controller: ThemeController(prefs),
      child: const EnterpriseUiPlaygroundApp(),
    ),
  );
  await tester.pumpAndSettle();

  final router = GoRouter.of(tester.element(find.byType(Navigator).first));

  for (final route in _routes) {
    router.go(route);
    await tester.pumpAndSettle();

    for (final size in _sizes) {
      tester.view.physicalSize = size;
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason: 'overflow/exception at $route @ $size (dark: $dark)',
      );
      // The page body must never force horizontal scrolling.
      expect(
        tester.view.physicalSize.width,
        size.width,
        reason: 'sanity: view size applied for $route',
      );
    }
  }
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('no overflow across breakpoints — light', (tester) async {
    await _run(tester, dark: false);
  });

  testWidgets('no overflow across breakpoints — dark', (tester) async {
    await _run(tester, dark: true);
  });
}
