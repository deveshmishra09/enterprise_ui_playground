import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the current [ThemeMode] and persists it (decision R13).
///
/// First visit defaults to light. "System" is not offered.
class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs) : _mode = _readMode(_prefs);

  static const String _key = 'theme_mode';

  final SharedPreferences _prefs;
  ThemeMode _mode;

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  static ThemeMode _readMode(SharedPreferences prefs) =>
      prefs.getString(_key) == 'dark' ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggle() =>
      setMode(isDark ? ThemeMode.light : ThemeMode.dark);

  Future<void> setMode(ThemeMode mode) async {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
    await _prefs.setString(_key, mode == ThemeMode.dark ? 'dark' : 'light');
  }
}

/// Exposes a [ThemeController] to the widget tree and rebuilds dependents when
/// the mode changes.
class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'ThemeScope not found in the widget tree');
    return scope!.notifier!;
  }
}
