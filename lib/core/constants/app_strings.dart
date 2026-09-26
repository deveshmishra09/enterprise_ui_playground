/// User-facing copy used in more than one place, or long enough to keep out of
/// widget code. Slot-specific one-offs can stay inline.
///
/// Strings tagged `TODO(copy)` are placeholders to be replaced before launch
/// (decision R4).
abstract final class AppStrings {
  static const String siteName = 'Enterprise UI Playground';

  // Slot 2 — Introduction
  static const String introEyebrow = 'BUILT WITH FLUTTER';
  static const String introHeadlinePrefix = 'Beautiful flows ';
  static const String introHeadlineAccent = 'for FlutterUI';

  // Slot 3 — Flows
  static const String flowsHeading = 'Explore the flows';

  // Slot 4 — Pricing
  static const String pricingEyebrow = 'PRICING';
  static const String pricingStatement =
      'Preview every flow live\nCustomize and download free\nflows.';
  static const String pricingSubline =
      'Try every flow in the browser, make it your own, then download the free ones';

  // Slot 5 — FAQ
  static const String faqHeading = 'Have any questions?';

  // Slot 6 — Get in touch
  static const String socialCtaPrefix = 'Still have a question? ';
  static const String socialCtaAction = 'Get in touch';
  static const String contactEyebrow = 'CONTACT';
  static const String contactHeading = 'Get in touch';
  static const String contactBody =
      'Questions about the Flows, your account, licensing, or an idea you would '
      'like to share? Choose the route that fits best.';
  static const String contactEmailLabel = 'EMAIL';
  static const String contactFollowLabel = 'FOLLOW';

  // Slot 7 — Footer
  static const String footerProductHeading = 'PRODUCT';
  static const String footerConnectHeading = 'CONNECT';
  static const String footerLegalHeading = 'LEGAL';
  static const String footerCopyrightPrefix =
      '© 2026 EnterpriseUIPlayground.app, Built with ❤️ by Devesh Mishra (';
  static const String footerCopyrightHandle = '@devesh_mishra09';
  static const String footerCopyrightSuffix = ')';

  // Preview / editor
  static const String previewLabel = 'Preview';
  static const String comingSoonLabel = 'Coming soon';
}
