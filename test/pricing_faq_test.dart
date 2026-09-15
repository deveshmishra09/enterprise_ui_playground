import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/data/faq_data.dart';
import 'package:enterprise_ui_playground/core/data/pricing_data.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/faq_tile.dart';
import 'package:enterprise_ui_playground/core/widgets/pricing_card.dart';

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

CrossFadeState _answerState(WidgetTester tester, int index) {
  final crossFade = tester.widget<AnimatedCrossFade>(
    find.descendant(
      of: find.byType(FaqTile).at(index),
      matching: find.byType(AnimatedCrossFade),
    ),
  );
  return crossFade.crossFadeState;
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Slot 4 shows both plans; the Plus card is primary-colored', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1440, 2600));

    expect(find.text('PRICING'), findsOneWidget);
    expect(find.byType(PricingCard), findsNWidgets(2));
    expect(find.text(kPlusPlan.name), findsOneWidget);

    final plusContainer = tester.widget<Container>(
      find.ancestor(
        of: find.text(kPlusPlan.tagline),
        matching: find.byType(Container),
      ).first,
    );
    final decoration = plusContainer.decoration! as BoxDecoration;
    expect(decoration.color, AppColors.primary);
  });

  testWidgets('pricing cards stack below desktop width', (tester) async {
    await _pumpApp(tester, size: const Size(700, 3000));
    expect(find.byType(IntrinsicHeight), findsNothing);

    await _pumpApp(tester, size: const Size(1440, 3000));
    expect(find.byType(IntrinsicHeight), findsOneWidget);
  });

  testWidgets('Slot 5 FAQ accordion opens one row at a time', (tester) async {
    await _pumpApp(tester, size: const Size(1440, 2600));

    expect(find.byType(FaqTile), findsNWidgets(kFaqItems.length));
    expect(_answerState(tester, 0), CrossFadeState.showFirst);

    Future<void> tapQuestion(int index) async {
      final question = find.text(kFaqItems[index].question);
      await tester.ensureVisible(question);
      await tester.pumpAndSettle();
      await tester.tap(question);
      await tester.pumpAndSettle();
    }

    await tapQuestion(0);
    expect(_answerState(tester, 0), CrossFadeState.showSecond);

    await tapQuestion(1);
    expect(_answerState(tester, 0), CrossFadeState.showFirst);
    expect(_answerState(tester, 1), CrossFadeState.showSecond);

    await tapQuestion(1);
    expect(_answerState(tester, 1), CrossFadeState.showFirst);
  });
}
