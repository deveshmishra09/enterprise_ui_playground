import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/models/app_flow.dart';
import 'package:enterprise_ui_playground/core/widgets/flow_card.dart';
import 'package:enterprise_ui_playground/core/widgets/flow_card_background.dart';

Future<void> _pumpCard(WidgetTester tester, AppFlow flow) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(width: 360, height: 240, child: FlowCard(flow: flow)),
        ),
      ),
    ),
  );
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  test('every flow has exactly four distinct background icons', () {
    // FlowCardBackground's layout places exactly four icons.
    for (final flow in kAllFlows) {
      expect(flow.backgroundIcons, hasLength(4), reason: flow.slug);
      expect(flow.backgroundIcons.toSet(), hasLength(4), reason: flow.slug);
    }
  });

  testWidgets('each flow card draws its own background icons', (tester) async {
    for (final flow in kAllFlows) {
      await _pumpCard(tester, flow);

      final background = tester.widget<FlowCardBackground>(
        find.byType(FlowCardBackground),
      );
      expect(background.icons, flow.backgroundIcons, reason: flow.slug);
      for (final icon in flow.backgroundIcons) {
        expect(find.byIcon(icon), findsOneWidget, reason: flow.slug);
      }
    }
  });

  testWidgets('hovering a card shows the spotlight and settles', (
    tester,
  ) async {
    await _pumpCard(tester, kAllFlows.first);

    double spotlightOpacity() => tester
        .widgetList<AnimatedOpacity>(
          find.descendant(
            of: find.byType(FlowCardBackground),
            matching: find.byType(AnimatedOpacity),
          ),
        )
        .first
        .opacity;

    expect(spotlightOpacity(), 0);

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    addTearDown(mouse.removePointer);

    await mouse.moveTo(tester.getCenter(find.byType(FlowCardBackground)));
    // Settling proves there's no looping ticker.
    await tester.pumpAndSettle();
    expect(spotlightOpacity(), 1);

    await mouse.moveTo(Offset.zero);
    await tester.pumpAndSettle();
    expect(spotlightOpacity(), 0);
  });
}
