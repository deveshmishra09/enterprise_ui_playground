/// Visual style of a pricing card. `free` = transparent/outlined,
/// `plus` = primary background with white foreground.
enum PricingVariant { free, plus }

/// A pricing tier shown in Slot 4. Presentational only this milestone —
/// see `docs/11-open-questions.md` R10/R11.
class PricingPlan {
  const PricingPlan({
    required this.name,
    required this.priceLabel,
    required this.cadenceLabel,
    required this.tagline,
    required this.features,
    required this.ctaLabel,
    required this.variant,
  });

  final String name;
  final String priceLabel;
  final String cadenceLabel;
  final String tagline;
  final List<String> features;
  final String ctaLabel;
  final PricingVariant variant;
}
