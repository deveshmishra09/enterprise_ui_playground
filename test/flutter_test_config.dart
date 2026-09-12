import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

/// Runs once for the whole `test/` suite (a name Flutter's test runner
/// recognizes automatically). Forces reduce-motion on so perpetually-looping
/// animations — e.g. the landing page's device-preview animation in
/// `IntroSection` — go idle immediately instead of leaving a Ticker running
/// forever, which would hang every `pumpAndSettle()` call in this suite.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.instance.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  await testMain();
}
