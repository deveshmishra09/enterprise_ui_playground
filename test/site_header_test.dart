import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/page_scaffold.dart';

Future<void> _pumpApp(WidgetTester tester, {required Size size}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  SharedPreferences.setMockInitialValues(<String, Object>{});
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ThemeScope(
      controller: ThemeController(prefs),
      child: const EnterpriseUiPlaygroundApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('desktop header shows the three nav links and no menu button', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1440, 900));

    expect(find.widgetWithText(TextButton, 'Flows'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Pricing'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'FAQ'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets('phone header collapses nav into a menu button', (tester) async {
    await _pumpApp(tester, size: const Size(390, 844));

    expect(find.widgetWithText(TextButton, 'Flows'), findsNothing);
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });

  testWidgets('preview header replaces nav with a centered Preview label', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1440, 900));

    final context = tester.element(find.byType(PageScaffold).first);
    context.go('/flows/content/drawing');
    await tester.pumpAndSettle();

    expect(find.text('Preview'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Flows'), findsNothing);
  });

  testWidgets('nav link routes to landing and scrolls to the section', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1440, 900));

    // Start from a sub-page so the nav link has to navigate back to '/'.
    tester.element(find.byType(PageScaffold).first).go('/contact');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Pricing'));
    await tester.pumpAndSettle();

    // The Slot 4 "PRICING" eyebrow is scrolled up near the top of the viewport.
    final target = find.text('PRICING');
    expect(target, findsOneWidget);
    expect(tester.getTopLeft(target).dy, lessThan(300));
  });
}
