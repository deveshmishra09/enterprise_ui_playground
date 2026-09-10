# 06 — Data Model

Single source of truth for flows/subflows: `lib/core/data/flows_data.dart`. The Slot 3
grid, the flow detail screen, the subflow editor list, and the router's slug validation
all read from it. Adding a subflow = adding one `SubFlow(...)` entry.

## Models

### `AppFlow` — `core/models/app_flow.dart`

Named `AppFlow`, not `Flow`, to avoid colliding with Flutter's `Flow` widget.

```dart
class AppFlow {
  final String slug;          // 'account-management'  (URL segment, unique)
  final String title;         // 'Account Management'
  final IconData icon;        // grid card icon
  final String blurb;         // one-line description for the flow detail header (TODO copy)
  final List<SubFlow> subFlows;

  const AppFlow({
    required this.slug,
    required this.title,
    required this.icon,
    required this.blurb,
    required this.subFlows,
  });

  int get count => subFlows.length;
}
```

### `SubFlow` — `core/models/sub_flow.dart`

```dart
class SubFlow {
  final String slug;                 // 'logging-in'  (URL segment, unique within a Flow)
  final String title;                // 'Logging In'
  final SubFlowStatus status;        // built | comingSoon
  final WidgetBuilder? screenBuilder; // non-null iff status == built

  const SubFlow({
    required this.slug,
    required this.title,
    this.status = SubFlowStatus.comingSoon,
    this.screenBuilder,
  });
}

enum SubFlowStatus { built, comingSoon }
```

Rule: `status == built` ⇒ `screenBuilder != null`. Enforced by an assert and a unit test.
`comingSoon` entries render `ComingSoonScreen` inside the device frame.

### `FaqItem` — `core/models/faq_item.dart`

```dart
class FaqItem {
  final String question;
  final String answer;   // plain text or lightweight markdown — TODO copy
  const FaqItem({required this.question, required this.answer});
}
```

### `PricingPlan` — `core/models/pricing_plan.dart`

```dart
class PricingPlan {
  final String name;              // 'Free' | 'Plus'
  final String priceLabel;        // '$0' | 'TODO'  (string, not a number, this milestone)
  final String cadenceLabel;      // 'forever' | 'TODO'
  final String tagline;           // short line under the name (TODO)
  final List<String> features;    // bullet list (TODO)
  final String ctaLabel;          // 'Browse flows' | 'TODO'
  final PricingVariant variant;   // free | plus
  const PricingPlan({ ... });
}

enum PricingVariant { free, plus }
```

## `flows_data.dart` shape

```dart
const List<AppFlow> kAllFlows = <AppFlow>[
  AppFlow(
    slug: 'account-management',
    title: 'Account Management',
    icon: Icons.manage_accounts_outlined,
    blurb: 'TODO(copy): ...',
    subFlows: <SubFlow>[
      SubFlow(
        slug: 'logging-in',
        title: 'Logging In',
        status: SubFlowStatus.built,
        screenBuilder: _loginScreen,   // top-level tear-off, keeps the list const
      ),
      SubFlow(slug: 'logging-out', title: 'Logging Out'), // comingSoon
      // …
    ],
  ),
  // …5 more flows
];

Widget _loginScreen(BuildContext context) => const LoginScreen();

// Lookups used by the router / pages:
AppFlow? flowBySlug(String slug) => ...
SubFlow? subFlowBySlug(String flowSlug, String subSlug) => ...
```

As of Phase 0, only `logging-in` is wired (`LoginScreen`); the other 70 are
`comingSoon`. The rest are wired in Phase 4.

Icons for the 6 flows are migrated from the current `lib/app_router.dart`
(`manage_accounts_outlined`, `account_balance`, `article`, `category`, `person_add`,
`groups`).

## Mapping existing demo screens

The wired `screenBuilder`s (verified against the current `lib/flows/**` tree):

| Flow | SubFlow slug | Screen widget (entry point) |
| --- | --- | --- |
| account-management | `deleting-deactivating-account` | `DeleteAccountScreen` (`…/delete_deactivate_account/screen/delete_account_screen.dart`) |
| account-management | `editing-profile` | `HomePageScreen` (`…/edit_profile/screen/home_page_screen.dart`) |
| account-management | `logging-in` | `LoginScreen` (`…/login/screens/login_screen.dart`) |
| account-management | `resetting-password` | `ResetPasswordLoginScreen` (`…/reset_password/screens/reset_password_login_screen.dart`) |
| commerce-finance | `adding-to-cart-bag` | `AddingToCartHomeScreen` (`…/adding_to_cart&bag/screens/adding_to_cart_home_screen.dart`) |
| commerce-finance | `booking-reserving` | `BookingHomeScreen` (`…/boopking&reserving/screens/booking_home_screen.dart`) |
| commerce-finance | `canceling-order-refunding` | `YourOrderScreen` (`…/cancelling_order&refunding/screens/your_order_screen.dart`) |
| commerce-finance | `listing` | `ListingHomeScreen` (`…/listing/screens/listing_home_screen.dart`) |
| commerce-finance | `purchasing-ordering` | `HomeScreen` (`…/purchasing&ordering.dart/screens/home_screen.dart`) |
| commerce-finance | `transferring-money-donating` | `TransferringMoneyHomeScreen` (`…/transferring_money&donating/screens/transferring_money_home_screen.dart`) |

Exact entry-point class per flow is confirmed during Phase 4 by opening each file (some
folders have multiple screens; the "home"/first screen is the entry). Everything else in
[`07-flow-catalogue.md`](07-flow-catalogue.md) is `comingSoon`.

> Note: `account_management_screen.dart` and `commerce_management_screen.dart` are
> existing *aggregator* screens. We bypass them — the playground composes its own flow
> detail screen from `kAllFlows` — but they stay in the repo untouched.

## Placeholder data files

- `faq_data.dart` — `kFaqItems`: 5 `FaqItem`s. Draft questions: *What is Enterprise UI
  Playground? / Are the flows really free? / Can I use these in commercial apps? / What's
  in Plus? / Is this built with Flutter?* Answers are 1–3 sentence `TODO` drafts.
- `pricing_data.dart` — `kFreePlan`, `kPlusPlan`. Free: `$0 / forever`, 3–4 bullets.
  Plus: `priceLabel: 'TODO'`, 4–5 bullets. All copy marked `// TODO(copy)`.

Every placeholder string is prefixed `TODO:` in the value **and** flagged with a
`// TODO(copy):` comment so they are greppable before launch.
