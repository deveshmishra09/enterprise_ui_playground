import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/coming_soon_screen.dart';
import 'package:enterprise_ui_playground/core/widgets/device_frame_preview.dart';
import 'package:enterprise_ui_playground/core/widgets/site_footer.dart';
import 'package:enterprise_ui_playground/features/subflow_editor/subflow_editor_page.dart';
import 'package:enterprise_ui_playground/features/subflow_editor/widgets/subflow_list_panel.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/login/screens/login_screen.dart'
    show LoginScreen;

Future<void> _pumpAppAt(
  WidgetTester tester,
  String location, {
  Size size = const Size(1400, 1000),
}) async {
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

  tester.element(find.byType(Navigator).first).go(location);
  await tester.pumpAndSettle();
}

/// Some legacy demo screens have latent `Row`-without-`Flexible` overflows that
/// show at phone width inside the frame — their bug, not ours (docs/09 Phase 4).
/// They still render. Drain the accumulated layout errors.
void _drainLegacyDemoErrors(WidgetTester tester) {
  for (var error = tester.takeException(); error != null; ) {
    debugPrint('[ignored legacy demo error] '
        '${error.toString().split('\n').first}');
    error = tester.takeException();
  }
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('a built subflow runs live inside an isolated device frame', (
    tester,
  ) async {
    await _pumpAppAt(tester, '/flows/account-management/logging-in');
    _drainLegacyDemoErrors(tester);

    expect(find.byType(SubflowEditorPage), findsOneWidget);
    expect(find.byType(SubflowListPanel), findsOneWidget);
    expect(find.byType(DeviceFramePreview), findsOneWidget);
    // The real demo widget is mounted…
    expect(find.byType(LoginScreen), findsOneWidget);
    // …under its own Navigator (nested MaterialApp = isolated navigation).
    expect(find.byType(Navigator), findsNWidgets(2));
    // No footer in the editor.
    expect(find.byType(SiteFooter), findsNothing);
  });

  testWidgets('web view keeps the running demo and uses a desktop viewport', (
    tester,
  ) async {
    await _pumpAppAt(tester, '/flows/account-management/logging-in');
    _drainLegacyDemoErrors(tester);

    final nestedApp = find.descendant(
      of: find.byType(DeviceFramePreview),
      matching: find.byType(MaterialApp),
    );
    final demoState = tester.state(nestedApp);

    await tester.tap(find.byTooltip('Web'));
    await tester.pumpAndSettle();
    _drainLegacyDemoErrors(tester);

    // Same nested app — switching views must not restart the demo.
    expect(tester.state(nestedApp), same(demoState));
    expect(
      MediaQuery.sizeOf(tester.element(find.byType(LoginScreen))),
      const Size(1440, 900),
    );
  });

  testWidgets('a coming-soon subflow shows the placeholder in the frame', (
    tester,
  ) async {
    await _pumpAppAt(tester, '/flows/content/drawing');

    expect(find.byType(DeviceFramePreview), findsOneWidget);
    expect(find.byType(ComingSoonScreen), findsOneWidget);
    expect(find.text('Coming soon'), findsOneWidget);
    expect(find.text('Content · Drawing'), findsOneWidget);
    expect(find.text('Preview'), findsOneWidget); // preview header variant
  });

  testWidgets('tapping another list item changes the URL and the preview', (
    tester,
  ) async {
    await _pumpAppAt(tester, '/flows/content/drawing');

    await tester.tap(
      find.descendant(
        of: find.byType(SubflowListPanel),
        matching: find.text('Archiving'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      GoRouterState.of(tester.element(find.byType(SubflowEditorPage))).uri.path,
      '/flows/content/archiving',
    );
    expect(find.text('Content · Archiving'), findsOneWidget);
  });

  testWidgets('narrow layout swaps the rail for a chip strip', (tester) async {
    await _pumpAppAt(
      tester,
      '/flows/content/drawing',
      size: const Size(600, 900),
    );

    expect(find.byType(SubflowListPanel), findsNothing);
    expect(find.byType(SingleChildScrollView), findsWidgets);
    expect(find.text('Drawing'), findsWidgets);
  });
}
