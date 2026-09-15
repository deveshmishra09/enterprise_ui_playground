import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:enterprise_ui_playground/core/widgets/device_frame_preview.dart';

/// Stand-in demo screen, so these tests don't depend on legacy demo layouts.
class _Probe extends StatelessWidget {
  const _Probe();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: SizedBox.expand());
}

Future<void> _pumpPreview(WidgetTester tester, ScreenView view) async {
  tester.view.physicalSize = const Size(1200, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DeviceFramePreview(screenView: view, child: const _Probe()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  const expected = <ScreenView, ({Size size, EdgeInsets padding})>{
    ScreenView.mobile: (
      size: Size(390, 844),
      padding: EdgeInsets.only(top: 47, bottom: 34),
    ),
    ScreenView.tablet: (size: Size(768, 1024), padding: EdgeInsets.zero),
    ScreenView.web: (size: Size(1440, 900), padding: EdgeInsets.zero),
  };

  for (final MapEntry(key: view, value: spec) in expected.entries) {
    testWidgets('${view.name} view runs the demo at its device metrics', (
      tester,
    ) async {
      await _pumpPreview(tester, view);

      final demo = tester.element(find.byType(_Probe));
      expect(MediaQuery.sizeOf(demo), spec.size);
      expect(MediaQuery.paddingOf(demo), spec.padding);
    });
  }

  testWidgets('only the web view shows the browser toolbar', (tester) async {
    final addressBar = find.text('yourapp.com').hitTestable();

    await _pumpPreview(tester, ScreenView.mobile);
    expect(addressBar, findsNothing);

    await _pumpPreview(tester, ScreenView.tablet);
    expect(addressBar, findsNothing);

    await _pumpPreview(tester, ScreenView.web);
    expect(addressBar, findsOneWidget);
  });
}
