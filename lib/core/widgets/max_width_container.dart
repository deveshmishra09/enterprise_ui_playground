import 'package:flutter/widgets.dart';

import '../constants/breakpoints.dart';

/// Centers its child, caps the width at [ResponsiveContext.contentMaxWidth], and
/// applies the responsive outer gutter. Every landing section and page body is
/// wrapped in one of these.
class MaxWidthContainer extends StatelessWidget {
  const MaxWidthContainer({
    super.key,
    required this.child,
    this.gutter = true,
  });

  final Widget child;

  /// Whether to apply the horizontal outer gutter. Disable when the child needs
  /// to bleed to the content edge.
  final bool gutter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: gutter ? context.outerGutter : 0,
          ),
          child: child,
        ),
      ),
    );
  }
}
