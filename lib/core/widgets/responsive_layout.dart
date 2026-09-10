import 'package:flutter/widgets.dart';

import '../constants/breakpoints.dart';

/// Builds a different subtree per [DeviceClass]. `tablet` falls back to `desktop`
/// when omitted.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.phone,
    this.tablet,
    required this.desktop,
  });

  final WidgetBuilder phone;
  final WidgetBuilder? tablet;
  final WidgetBuilder desktop;

  @override
  Widget build(BuildContext context) {
    switch (context.deviceClass) {
      case DeviceClass.phone:
        return phone(context);
      case DeviceClass.tablet:
        return (tablet ?? desktop)(context);
      case DeviceClass.desktop:
        return desktop(context);
    }
  }
}
