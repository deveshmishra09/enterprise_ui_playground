import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/page_scaffold.dart';
import 'package:enterprise_ui_playground/core/widgets/sub_flow_card.dart';
import 'package:enterprise_ui_playground/features/flow_detail/flow_detail_page.dart';
import 'package:enterprise_ui_playground/features/landing/landing_page.dart';
import 'package:enterprise_ui_playground/features/subflow_editor/subflow_editor_page.dart';

Future<void> _pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1400, 2400);
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

BuildContext _ctx(WidgetTester tester) =>
    tester.element(find.byType(PageScaffold).first);

BuildContext _ctx2(WidgetTester tester) =>
    tester.element(find.byType(SubflowEditorPage).first);

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('each flow lists its subflows with the right count', (
    tester,
  ) async {
    await _pumpApp(tester);

    for (final flow in kAllFlows) {
      _ctx(tester).go('/flows/${flow.slug}');
      await tester.pumpAndSettle();

      expect(find.byType(FlowDetailPage), findsOneWidget, reason: flow.slug);
      expect(
        find.byType(SubFlowCard),
        findsNWidgets(flow.count),
        reason: flow.slug,
      );
      expect(find.text('${flow.count} subflows'), findsOneWidget);
      expect(
        find.text(flow.subFlows.first.title),
        findsWidgets,
        reason: flow.slug,
      );
    }
  });

  testWidgets('expected per-flow counts', (tester) async {
    await _pumpApp(tester);
    const expected = {
      'account-management': 6,
      'commerce-finance': 9,
      'content': 24,
      'misc': 9,
      'new-user-experience': 4,
      'social': 19,
    };
    for (final entry in expected.entries) {
      expect(flowBySlug(entry.key)!.count, entry.value);
    }
  });

  testWidgets('tapping a subflow card opens the editor route', (tester) async {
    await _pumpApp(tester);
    _ctx(tester).go('/flows/account-management');
    await tester.pumpAndSettle();

    // Tap a coming-soon card so no legacy demo is mounted here.
    await tester.tap(find.text('Switching Account'));
    await tester.pumpAndSettle();

    expect(find.byType(SubflowEditorPage), findsOneWidget);
    expect(
      GoRouterState.of(_ctx2(tester)).uri.path,
      '/flows/account-management/switching-account',
    );
  });

  testWidgets('unknown flow slug redirects to the landing page', (tester) async {
    await _pumpApp(tester);
    _ctx(tester).go('/flows/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.byType(LandingPage), findsOneWidget);
    expect(find.byType(FlowDetailPage), findsNothing);
  });
}
