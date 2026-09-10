import 'package:flutter/widgets.dart';

/// Whether a subflow has a real demo screen or is still a placeholder.
enum SubFlowStatus { built, comingSoon }

/// A single interaction pattern inside an [AppFlow].
///
/// See `lib/core/data/flows_data.dart` for the catalogue and
/// `docs/07-flow-catalogue.md` for the full list.
class SubFlow {
  const SubFlow({
    required this.slug,
    required this.title,
    this.status = SubFlowStatus.comingSoon,
    this.screenBuilder,
  }) : assert(
         status != SubFlowStatus.built || screenBuilder != null,
         'A built SubFlow must provide a screenBuilder',
       );

  /// URL segment, kebab-case, unique within its flow (e.g. `logging-in`).
  final String slug;

  /// Human-readable name (e.g. `Logging In`).
  final String title;

  final SubFlowStatus status;

  /// Builds the live demo screen. Non-null iff [status] is [SubFlowStatus.built].
  final WidgetBuilder? screenBuilder;

  bool get isBuilt => status == SubFlowStatus.built;
}
