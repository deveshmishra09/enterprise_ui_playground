import 'package:flutter/widgets.dart';

import 'sub_flow.dart';

/// One of the six top-level flow categories shown in the Slot 3 grid.
///
/// Named `AppFlow` (not `Flow`) to avoid colliding with Flutter's `Flow` widget.
class AppFlow {
  const AppFlow({
    required this.slug,
    required this.title,
    required this.icon,
    required this.blurb,
    required this.subFlows,
  });

  /// URL segment, kebab-case, unique (e.g. `account-management`).
  final String slug;

  /// Human-readable name (e.g. `Account Management`).
  final String title;

  /// Grid card icon.
  final IconData icon;

  /// One-line description for the flow detail header. `TODO(copy)` for now.
  final String blurb;

  final List<SubFlow> subFlows;

  int get count => subFlows.length;
}
