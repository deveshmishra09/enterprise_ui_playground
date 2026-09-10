import 'package:flutter/material.dart';

import 'grid_background.dart';
import 'site_footer.dart';
import 'site_header.dart';

/// Standard page shell: a fixed [SiteHeader] that never scrolls, a scrolling
/// body over a painted [GridBackground] (both themes), and an optional
/// [SiteFooter] at the end of the scroll.
///
/// Used by the landing page and every content page. The subflow editor builds
/// its own layout instead.
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.child,
    this.headerVariant = SiteHeaderVariant.defaultNav,
    this.showFooter = true,
    this.scrollController,
  });

  final Widget child;
  final SiteHeaderVariant headerVariant;
  final bool showFooter;

  /// Supply when the page needs to drive the scroll position itself (the
  /// landing page uses this to jump to sections).
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        child: Column(
          children: [
            SiteHeader(variant: headerVariant),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    child,
                    if (showFooter) const SiteFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
