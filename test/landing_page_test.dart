import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/flow_card.dart';
import 'package:enterprise_ui_playground/core/widgets/highlighted_text.dart';
import 'package:enterprise_ui_playground/features/flow_detail/flow_detail_page.dart';

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

double _headlineFontSize(WidgetTester tester) {
  final headline = tester.widget<HighlightedText>(find.byType(HighlightedText));
  return headline.style.fontSize!;
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Slot 2 shows the eyebrow and the highlighted headline', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1440, 900));

    expect(find.text(AppStrings.introEyebrow), findsOneWidget);
    expect(find.byType(HighlightedText), findsOneWidget);
  });

  testWidgets('Slot 3 renders all six flow cards with titles', (tester) async {
    await _pumpApp(tester, size: const Size(1440, 1200));

    expect(find.text(AppStrings.flowsHeading), findsOneWidget);
    expect(find.byType(FlowCard), findsNWidgets(kAllFlows.length));
    for (final flow in kAllFlows) {
      expect(find.text(flow.title), findsOneWidget);
    }
  });

  testWidgets('tapping a flow card opens /flows/<slug>', (tester) async {
    await _pumpApp(tester, size: const Size(1440, 1200));

    await tester.ensureVisible(find.text('Content'));
    await tester.tap(find.text('Content'));
    await tester.pumpAndSettle();

    expect(find.byType(FlowDetailPage), findsOneWidget);
    expect(find.text('24 subflows'), findsOneWidget);
  });

  testWidgets('headline font size steps down from desktop to phone', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1440, 900));
    final desktop = _headlineFontSize(tester);

    // Resize the live tree rather than re-pumping (the router is a singleton).
    tester.view.physicalSize = const Size(390, 844);
    await tester.pumpAndSettle();
    final phone = _headlineFontSize(tester);

    expect(desktop, greaterThan(phone));
  });
}
