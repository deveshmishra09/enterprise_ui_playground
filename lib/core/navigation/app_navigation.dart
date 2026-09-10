import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// The scrollable sections on the landing route (`/`).
enum LandingSection { flows, pricing, faq }

/// A request to scroll the landing page to [section]. The [token] is a fresh
/// object per call so the landing page re-scrolls even when the same section is
/// requested twice (enum values compare equal; [token] does not).
typedef SectionRequest = ({LandingSection section, Object token});

/// Navigate to a landing section from anywhere. Works whether or not the user is
/// already on `/`.
void goToLandingSection(BuildContext context, LandingSection section) {
  context.go('/', extra: (section: section, token: Object()));
}

/// Opens an external URL — a new tab on web, the default handler elsewhere.
Future<void> openExternalUrl(String url) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
  } catch (error) {
    debugPrint('openExternalUrl failed for "$url": $error');
  }
}
