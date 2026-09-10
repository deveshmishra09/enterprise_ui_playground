import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/constants/app_strings.dart';
import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/models/sub_flow.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/site_header.dart';

void main() {
  // Don't try to fetch fonts over the network during tests.
  GoogleFonts.config.allowRuntimeFetching = false;

  group('flow catalogue', () {
    test('has 6 flows and 71 subflows', () {
      expect(kAllFlows.length, 6);
      final total = kAllFlows.fold<int>(0, (sum, f) => sum + f.subFlows.length);
      expect(total, 71);
    });

    test('flow and subflow slugs are unique', () {
      final flowSlugs = kAllFlows.map((f) => f.slug).toList();
      expect(flowSlugs.toSet().length, flowSlugs.length);

      for (final flow in kAllFlows) {
        final subSlugs = flow.subFlows.map((s) => s.slug).toList();
        expect(
          subSlugs.toSet().length,
          subSlugs.length,
          reason: 'duplicate subflow slug in ${flow.slug}',
        );
      }
    });

    test('built subflows provide a screenBuilder', () {
      for (final flow in kAllFlows) {
        for (final sub in flow.subFlows) {
          if (sub.status == SubFlowStatus.built) {
            expect(
              sub.screenBuilder,
              isNotNull,
              reason: '${flow.slug}/${sub.slug}',
            );
          }
        }
      }
    });

    test('lookups resolve and reject unknown slugs', () {
      expect(flowBySlug('content')?.title, 'Content');
      expect(flowBySlug('nope'), isNull);
      expect(subFlowBySlug('content', 'drawing')?.title, 'Drawing');
      expect(subFlowBySlug('content', 'nope'), isNull);
      expect(subFlowBySlug('nope', 'drawing'), isNull);
    });
  });

  testWidgets('app boots to the landing route inside the global shell', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ThemeScope(
        controller: ThemeController(prefs),
        child: const EnterpriseUiPlaygroundApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SiteHeader), findsOneWidget);
    expect(find.text(AppStrings.siteName), findsOneWidget);
  });
}
