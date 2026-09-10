/// External URLs and contact details. Kept in one place so they can be updated
/// without hunting through widgets.
abstract final class AppLinks {
  static const String xHandle = '@deveshmishra_09';
  static const String xUrl = 'https://x.com/deveshmishra_09';

  static const String contactEmail = 'devesh09269@gmail.com';
  static String get mailto => 'mailto:$contactEmail';

  // Reference-only — used while authoring `/support`, `/privacy`, `/terms` copy.
  // Not linked from the production UI.
  static const String refSupport = 'https://www.withanimation.app/support';
  static const String refPrivacy = 'https://www.withanimation.app/privacy';
  static const String refTerms = 'https://www.withanimation.app/terms';
}
