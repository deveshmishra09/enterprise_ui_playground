import 'package:flutter/widgets.dart';

/// Lets a live demo, running deep inside the [DeviceFramePreview]'s nested
/// Navigator, ask the editor to reset the preview back to the subflow's
/// initial screen — instead of navigating to a real destination it doesn't
/// have (e.g. the old account/commerce hub grids).
class SubflowResetScope extends InheritedWidget {
  const SubflowResetScope({
    super.key,
    required this.reset,
    required super.child,
  });

  final VoidCallback reset;

  static SubflowResetScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SubflowResetScope>();
  }

  @override
  bool updateShouldNotify(SubflowResetScope oldWidget) =>
      reset != oldWidget.reset;
}
