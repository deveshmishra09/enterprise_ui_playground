import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/navigation/app_navigation.dart';
import 'package:enterprise_ui_playground/core/widgets/page_scaffold.dart';
import 'package:enterprise_ui_playground/features/contact/contact_page.dart';
import 'package:enterprise_ui_playground/features/flow_detail/flow_detail_page.dart';
import 'package:enterprise_ui_playground/features/landing/landing_page.dart';
import 'package:enterprise_ui_playground/features/privacy/privacy_page.dart';
import 'package:enterprise_ui_playground/features/subflow_editor/subflow_editor_page.dart';
import 'package:enterprise_ui_playground/features/support/support_page.dart';
import 'package:enterprise_ui_playground/features/terms/terms_page.dart';

/// App routes. Path URLs (no `#`) — see `docs/02-information-architecture.md`.
///
/// Phase 2: real landing page (Slots 2–3), other routes are still stubs inside
/// the real shell.
///
/// Created per [MaterialApp.router] (see `app.dart`) rather than as a global, so
/// navigation state never leaks between app instances (tests, hot restart).
GoRouter createAppRouter() => GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const _StubPage(
    title: 'Not found',
    body: 'This route does not exist.',
  ),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        final extra = state.extra;
        return LandingPage(request: extra is SectionRequest ? extra : null);
      },
    ),
    GoRoute(
      path: '/flows/:flowSlug',
      redirect: (context, state) =>
          flowBySlug(state.pathParameters['flowSlug']!) == null ? '/' : null,
      builder: (context, state) =>
          FlowDetailPage(flow: flowBySlug(state.pathParameters['flowSlug']!)!),
    ),
    GoRoute(
      path: '/flows/:flowSlug/:subFlowSlug',
      redirect: (context, state) {
        final sub = subFlowBySlug(
          state.pathParameters['flowSlug']!,
          state.pathParameters['subFlowSlug']!,
        );
        return sub == null ? '/flows/${state.pathParameters['flowSlug']}' : null;
      },
      builder: (context, state) {
        final flowSlug = state.pathParameters['flowSlug']!;
        return SubflowEditorPage(
          flow: flowBySlug(flowSlug)!,
          subFlow: subFlowBySlug(
            flowSlug,
            state.pathParameters['subFlowSlug']!,
          )!,
        );
      },
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactPage(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportPage(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyPage(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsPage(),
    ),
  ],
);

/// Placeholder page body inside the real shell (contact / legal / not-found).
class _StubPage extends StatelessWidget {
  const _StubPage({required this.title, this.body});

  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            if (body != null) ...[
              const SizedBox(height: 8),
              Text(body!, textAlign: TextAlign.center),
            ],
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Back to landing'),
            ),
          ],
        ),
      ),
    );
  }
}
