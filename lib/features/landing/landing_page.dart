import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/navigation/app_navigation.dart';
import 'package:enterprise_ui_playground/core/widgets/page_scaffold.dart';
import 'package:enterprise_ui_playground/features/landing/sections/faq_section.dart';
import 'package:enterprise_ui_playground/features/landing/sections/flows_section.dart';
import 'package:enterprise_ui_playground/features/landing/sections/intro_section.dart';
import 'package:enterprise_ui_playground/features/landing/sections/pricing_section.dart';
import 'package:enterprise_ui_playground/features/landing/sections/social_cta_section.dart';

/// Route `/`. Assembles the seven slots in one scroll and jumps to a section
/// when a header/footer link asks for one via [SectionRequest].
///
/// Phase 2: Slots 2 (intro) and 3 (flows grid) are real. Slots 4–6 are
/// placeholders so the Pricing / FAQ / contact anchors still resolve.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key, this.request});

  final SectionRequest? request;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _scrollController = ScrollController();
  final _flowsKey = GlobalKey();
  final _pricingKey = GlobalKey();
  final _faqKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.request != null) _scrollTo(widget.request!.section);
  }

  @override
  void didUpdateWidget(covariant LandingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final request = widget.request;
    if (request != null && request != oldWidget.request) {
      _scrollTo(request.section);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(LandingSection section) {
    final key = switch (section) {
      LandingSection.flows => _flowsKey,
      LandingSection.pricing => _pricingKey,
      LandingSection.faq => _faqKey,
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetContext = key.currentContext;
      if (!mounted || targetContext == null) return;
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      scrollController: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IntroSection(),
          KeyedSubtree(key: _flowsKey, child: const FlowsSection()),
          KeyedSubtree(key: _pricingKey, child: const PricingSection()),
          KeyedSubtree(key: _faqKey, child: const FaqSection()),
          const SocialCtaSection(),
        ],
      ),
    );
  }
}
