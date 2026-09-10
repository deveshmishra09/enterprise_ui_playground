import 'package:enterprise_ui_playground/core/models/pricing_plan.dart';

// TODO(copy): amounts, cadence and wording below are placeholder drafts —
// replace before launch (decisions R4, R10, R11). "Plus" is presentational only;
// its CTA routes to /contact.
const PricingPlan kFreePlan = PricingPlan(
  name: 'FREE',
  priceLabel: r'$0',
  cadenceLabel: 'forever',
  tagline: 'Everything you need to try and ship the free flows.',
  features: <String>[
    'Preview every flow in the browser',
    'Download the free flows',
    'Light & dark, responsive layouts',
  ],
  ctaLabel: 'Browse flows',
  variant: PricingVariant.free,
);

const PricingPlan kPlusPlan = PricingPlan(
  name: 'PLUS',
  priceLabel: r'$—',
  cadenceLabel: 'pricing soon',
  tagline: 'Every flow, with source for every subflow.',
  features: <String>[
    'All 71 subflows',
    'Full source for every subflow',
    'New flows as they land',
    'Commercial license',
  ],
  ctaLabel: 'Get in touch',
  variant: PricingVariant.plus,
);

const List<PricingPlan> kPricingPlans = <PricingPlan>[kFreePlan, kPlusPlan];
