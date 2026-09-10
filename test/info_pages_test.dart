import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enterprise_ui_playground/app.dart';
import 'package:enterprise_ui_playground/core/constants/app_links.dart';
import 'package:enterprise_ui_playground/core/theme/theme_controller.dart';
import 'package:enterprise_ui_playground/core/widgets/info_page_scaffold.dart';
import 'package:enterprise_ui_playground/core/widgets/site_footer.dart';
import 'package:enterprise_ui_playground/core/widgets/site_header.dart';
import 'package:enterprise_ui_playground/features/contact/contact_page.dart';
import 'package:enterprise_ui_playground/features/landing/sections/social_cta_section.dart';

Future<void> _pumpAt(
  WidgetTester tester,
  String location, {
  Size size = const Size(1400, 1600),
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

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('the Slot 6 CTA routes to the contact page', (tester) async {
    await _pumpAt(tester, '/');

    final cta = find.descendant(
      of: find.byType(SocialCtaSection),
      matching: find.text('Get in touch'),
    );
    await tester.ensureVisible(cta);
    await tester.pumpAndSettle();
    await tester.tap(cta);
    await tester.pumpAndSettle();

    expect(find.byType(ContactPage), findsOneWidget);
  });

  testWidgets('contact page renders the hero and contact rows', (tester) async {
    await _pumpAt(tester, '/contact');

    expect(find.byType(InfoPageScaffold), findsOneWidget);
    expect(find.byType(SiteHeader), findsOneWidget);
    expect(find.byType(SiteFooter), findsOneWidget);
    expect(find.text('CONTACT'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text(AppLinks.contactEmail), findsOneWidget);
    expect(find.text('FOLLOW'), findsOneWidget);
    expect(find.text(AppLinks.xHandle), findsWidgets);
  });

  for (final (route, eyebrow) in const [
    ('/support', 'SUPPORT'),
    ('/privacy', 'PRIVACY'),
    ('/terms', 'TERMS'),
  ]) {
    testWidgets('$route renders the shared shell', (tester) async {
      await _pumpAt(tester, route);

      expect(find.byType(InfoPageScaffold), findsOneWidget);
      expect(find.byType(SiteFooter), findsOneWidget);
      expect(find.text(eyebrow), findsOneWidget);
    });
  }

  testWidgets('contact rows stack on phone', (tester) async {
    await _pumpAt(tester, '/contact', size: const Size(390, 1600));

    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text(AppLinks.contactEmail), findsOneWidget);
  });
}
