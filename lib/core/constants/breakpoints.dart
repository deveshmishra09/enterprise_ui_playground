import 'package:flutter/widgets.dart';

/// Responsive device classes. Thresholds match the ones used by the original
/// `lib/app_router.dart` (`phone < 600`, `tablet 600–1024`).
enum DeviceClass { phone, tablet, desktop }

abstract final class Breakpoints {
  static const double phoneMax = 600;
  static const double tabletMax = 1024;

  static const double tabletContentMax = 760;
  static const double desktopContentMax = 1160;

  /// Below this the subflow editor switches from the side-rail layout to the
  /// stacked chip-strip layout (decision R5).
  static const double editorStackBelow = 900;

  static DeviceClass of(double width) {
    if (width < phoneMax) return DeviceClass.phone;
    if (width < tabletMax) return DeviceClass.tablet;
    return DeviceClass.desktop;
  }
}

/// Ergonomic responsive helpers on [BuildContext].
extension ResponsiveContext on BuildContext {
  DeviceClass get deviceClass => Breakpoints.of(MediaQuery.sizeOf(this).width);

  bool get isPhone => deviceClass == DeviceClass.phone;
  bool get isTablet => deviceClass == DeviceClass.tablet;
  bool get isDesktop => deviceClass == DeviceClass.desktop;

  /// Pick a value per device class. `tablet` falls back to `desktop` if omitted.
  T responsive<T>({required T phone, T? tablet, required T desktop}) {
    switch (deviceClass) {
      case DeviceClass.phone:
        return phone;
      case DeviceClass.tablet:
        return tablet ?? desktop;
      case DeviceClass.desktop:
        return desktop;
    }
  }

  double get outerGutter => responsive(phone: 16, tablet: 24, desktop: 32);

  double get contentMaxWidth => responsive(
    phone: double.infinity,
    tablet: Breakpoints.tabletContentMax,
    desktop: Breakpoints.desktopContentMax,
  );

  int get gridColumns => responsive(phone: 1, tablet: 2, desktop: 3);

  /// Vertical gap between landing-page slots.
  double get sectionGap => responsive(phone: 56, tablet: 72, desktop: 96);
}
