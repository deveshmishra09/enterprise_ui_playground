import 'package:enterprise_ui_playground/flows/01_account_management/logout/screens/logout_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/screens/order_tracking_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/screens/cancelling_subscription_home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/redeeming/screens/redeeming_home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/screens/subscribing_upgrading_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/copying&dulpicating/screens/copying_duplicating_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/importing&exporting/screens/import_export_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/uploading&downloading/screens/uploading_downloading_home_screen.dart';
import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/models/app_flow.dart';
import 'package:enterprise_ui_playground/core/models/sub_flow.dart';

// Existing demo screens. `show` keeps each import to the one entry-point class
// so unrelated top-level names in those files can't collide.
import 'package:enterprise_ui_playground/flows/01_account_management/delete_deactivate_account/screen/delete_account_screen.dart'
    show DeleteAccountScreen;
import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/screen/home_page_screen.dart'
    show HomePageScreen;
import 'package:enterprise_ui_playground/flows/01_account_management/login/screens/login_screen.dart'
    show LoginScreen;
import 'package:enterprise_ui_playground/flows/01_account_management/reset_password/screens/reset_password_login_screen.dart'
    show ResetPasswordLoginScreen;
import 'package:enterprise_ui_playground/flows/02_commerce&finance/adding_to_cart&bag/screens/adding_to_cart_home_screen.dart'
    show AddingToCartHomeScreen;
import 'package:enterprise_ui_playground/flows/02_commerce&finance/booking&reserving/screens/booking_home_screen.dart'
    show BookingHomeScreen;
import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/screens/listing_home_screen.dart'
    show ListingHomeScreen;
import 'package:enterprise_ui_playground/flows/02_commerce&finance/purchasing&ordering.dart/screens/home_screen.dart'
    show HomeScreen;
import 'package:enterprise_ui_playground/flows/02_commerce&finance/transferring_money&donating/screens/transferring_money_home_screen.dart'
    show TransferringHomeScreen;

/// The single source of truth for the 6 flows and 71 subflows.
///
/// The Slot 3 grid, the flow detail screen, the subflow editor list, and the
/// router's slug validation all read from here. Adding a subflow = adding one
/// [SubFlow] entry. Wire a real demo by setting `status: SubFlowStatus.built`
/// and a `screenBuilder`. Full list + status: `docs/07-flow-catalogue.md`.
const List<AppFlow> kAllFlows = <AppFlow>[
  AppFlow(
    slug: 'account-management',
    title: 'Account Management',
    icon: Icons.manage_accounts_outlined,
    backgroundIcons: <IconData>[
      Icons.person_outline,
      Icons.lock_outline,
      Icons.verified_user_outlined,
      Icons.switch_account_outlined,
    ],
    blurb: 'TODO(copy): sign-in, profile, and account lifecycle patterns.',
    subFlows: <SubFlow>[
      SubFlow(
        slug: 'logging-in',
        title: 'Logging In',
        status: SubFlowStatus.built,
        screenBuilder: _loginScreen,
      ),
      SubFlow(
        slug: 'editing-profile',
        title: 'Editing Profile',
        status: SubFlowStatus.built,
        screenBuilder: _editProfileScreen,
      ),
      SubFlow(
        slug: 'logging-out',
        title: 'Logging Out',
        status: SubFlowStatus.built,
        screenBuilder: _logoutScreen,
      ),
      SubFlow(
        slug: 'resetting-password',
        title: 'Resetting Password',
        status: SubFlowStatus.built,
        screenBuilder: _resetPasswordScreen,
      ),
      SubFlow(
        slug: 'deleting-deactivating-account',
        title: 'Deleting & Deactivating Account',
        status: SubFlowStatus.built,
        screenBuilder: _deleteAccountScreen,
      ),
      SubFlow(slug: 'switching-account', title: 'Switching Account'),
    ],
  ),
  AppFlow(
    slug: 'commerce-finance',
    title: 'Commerce & Finance',
    icon: Icons.account_balance,
    backgroundIcons: <IconData>[
      Icons.shopping_cart_outlined,
      Icons.credit_card_outlined,
      Icons.receipt_long_outlined,
      Icons.account_balance_wallet_outlined,
    ],
    blurb: 'TODO(copy): carts, checkout, subscriptions, and money movement.',
    subFlows: <SubFlow>[
      SubFlow(
        slug: 'listing',
        title: 'Listing',
        status: SubFlowStatus.built,
        screenBuilder: _listingScreen,
      ),
      SubFlow(
        slug: 'adding-to-cart-bag',
        title: 'Adding to Cart & Bag',
        status: SubFlowStatus.built,
        screenBuilder: _addingToCartScreen,
      ),
      SubFlow(
        slug: 'purchasing-ordering',
        title: 'Purchasing & Ordering',
        status: SubFlowStatus.built,
        screenBuilder: _purchasingScreen,
      ),
      SubFlow(
        slug: 'booking-reserving',
        title: 'Booking & Reserving',
        status: SubFlowStatus.built,
        screenBuilder: _bookingScreen,
      ),
      SubFlow(
        slug: 'canceling-order-refunding',
        title: 'Canceling Order & Refunding',
        status: SubFlowStatus.built,
        screenBuilder: _orderTrackingScreen,
      ),
      SubFlow(
        slug: 'transferring-money-donating',
        title: 'Transferring Money & Donating',
        status: SubFlowStatus.built,
        screenBuilder: _transferringScreen,
      ),
      SubFlow(
        slug: 'subscribing-upgrading',
        title: 'Subscribing & Upgrading',
        status: SubFlowStatus.built,
        screenBuilder: _subscribingUpgradingScreen,
      ),
      SubFlow(slug: 'canceling-subscription', title: 'Canceling Subscription', status: SubFlowStatus.built, screenBuilder: _cancelingSubscriptionScreen),
      SubFlow(slug: 'redeeming', title: 'Redeeming', status: SubFlowStatus.built, screenBuilder: _redeemingHomeScreen),
    ],
  ),
  AppFlow(
    slug: 'content',
    title: 'Content',
    icon: Icons.article_outlined,
    backgroundIcons: <IconData>[
      Icons.edit_outlined,
      Icons.photo_camera_outlined,
      Icons.play_circle_outline,
      Icons.cloud_upload_outlined,
    ],
    blurb: 'TODO(copy): creating, organizing, and consuming content.',
    subFlows: <SubFlow>[
      SubFlow(slug: 'copying-duplicating', title: 'Copying & Duplicating', status: SubFlowStatus.built, screenBuilder: _copyingDuplicatingHomeScreen),
      SubFlow(slug: 'importing-exporting', title: 'Importing & Exporting', status: SubFlowStatus.built, screenBuilder: _importExportHomeScreen),
      SubFlow(slug: 'uploading-downloading', title: 'Uploading & Downloading', status: SubFlowStatus.built, screenBuilder: _uploadingDownloadingHomeScreen),
      SubFlow(slug: 'adding-creating', title: 'Adding & Creating'),
      SubFlow(slug: 'drawing', title: 'Drawing'),
      SubFlow(slug: 'editing-updating', title: 'Editing & Updating'),
      SubFlow(slug: 'deleting-removing', title: 'Deleting & Removing'),
      SubFlow(slug: 'archiving', title: 'Archiving'),
      SubFlow(slug: 'favoriting-pinning', title: 'Favoriting & Pinning'),
      SubFlow(slug: 'filtering-sorting', title: 'Filtering & Sorting'),
      SubFlow(slug: 'moving', title: 'Moving'),
      SubFlow(slug: 'reordering', title: 'Reordering'),
      SubFlow(slug: 'saving-to-collection', title: 'Saving to Collection'),
      SubFlow(slug: 'searching-finding', title: 'Searching & Finding'),
      SubFlow(slug: 'selecting-choosing', title: 'Selecting & Choosing'),
      SubFlow(slug: 'listening-to-audio', title: 'Listening to Audio'),
      SubFlow(slug: 'recording-audio-video', title: 'Recording Audio & Video'),
      SubFlow(slug: 'scanning', title: 'Scanning'),
      SubFlow(slug: 'taking-photos', title: 'Taking Photos'),
      SubFlow(slug: 'watching-video', title: 'Watching Video'),
      SubFlow(slug: 'logging-tracking', title: 'Logging & Tracking'),
      SubFlow(slug: 'marking', title: 'Marking'),
      SubFlow(slug: 'publishing', title: 'Publishing'),
      SubFlow(slug: 'starting-completing', title: 'Starting & Completing'),
    ],
  ),
  AppFlow(
    slug: 'misc',
    title: 'Misc',
    icon: Icons.category_outlined,
    backgroundIcons: <IconData>[
      Icons.toggle_on_outlined,
      Icons.dark_mode_outlined,
      Icons.link,
      Icons.visibility_outlined,
    ],
    blurb: 'TODO(copy): settings, toggles, and everything in between.',
    subFlows: <SubFlow>[
      SubFlow(slug: 'connecting-linking', title: 'Connecting & Linking'),
      SubFlow(slug: 'enabling-disabling', title: 'Enabling & Disabling'),
      SubFlow(slug: 'misc', title: 'Misc'),
      SubFlow(slug: 'setting-up', title: 'Setting Up'),
      SubFlow(slug: 'showing-hiding', title: 'Showing & Hiding'),
      SubFlow(slug: 'switching-view', title: 'Switching View'),
      SubFlow(slug: 'switching-to-dark-mode', title: 'Switching to Dark Mode'),
      SubFlow(slug: 'turning-on-off', title: 'Turning On/Off'),
      SubFlow(slug: 'verifying', title: 'Verifying'),
    ],
  ),
  AppFlow(
    slug: 'new-user-experience',
    title: 'New User Experience',
    icon: Icons.person_add_alt_1_outlined,
    backgroundIcons: <IconData>[
      Icons.waving_hand_outlined,
      Icons.person_add_alt_outlined,
      Icons.school_outlined,
      Icons.assignment_outlined,
    ],
    blurb: 'TODO(copy): first-run, sign-up, and onboarding.',
    subFlows: <SubFlow>[
      SubFlow(slug: 'browsing-tutorial', title: 'Browsing Tutorial'),
      SubFlow(slug: 'creating-account', title: 'Creating Account'),
      SubFlow(slug: 'onboarding', title: 'Onboarding'),
      SubFlow(slug: 'onboarding-forms', title: 'Onboarding Forms'),
    ],
  ),
  AppFlow(
    slug: 'social',
    title: 'Social',
    icon: Icons.groups_outlined,
    backgroundIcons: <IconData>[
      Icons.chat_bubble_outline,
      Icons.favorite_border,
      Icons.call_outlined,
      Icons.share_outlined,
    ],
    blurb: 'TODO(copy): people, messaging, and community actions.',
    subFlows: <SubFlow>[
      SubFlow(slug: 'banning-blocking', title: 'Banning & Blocking'),
      SubFlow(slug: 'calling', title: 'Calling'),
      SubFlow(
        slug: 'chatting-sending-messages',
        title: 'Chatting & Sending Messages',
      ),
      SubFlow(slug: 'commenting-replying', title: 'Commenting & Replying'),
      SubFlow(slug: 'following-subscribing', title: 'Following & Subscribing'),
      SubFlow(slug: 'gifting', title: 'Gifting'),
      SubFlow(slug: 'giving-feedback', title: 'Giving Feedback'),
      SubFlow(
        slug: 'inviting-teammates-friends',
        title: 'Inviting Teammates & Friends',
      ),
      SubFlow(slug: 'joining-accepting', title: 'Joining & Accepting'),
      SubFlow(slug: 'leaving', title: 'Leaving'),
      SubFlow(slug: 'liking-upvoting', title: 'Liking & Upvoting'),
      SubFlow(slug: 'muting', title: 'Muting'),
      SubFlow(slug: 'referring-friends', title: 'Referring Friends'),
      SubFlow(slug: 'registering', title: 'Registering'),
      SubFlow(slug: 'reporting', title: 'Reporting'),
      SubFlow(slug: 'requesting', title: 'Requesting'),
      SubFlow(slug: 'reviewing-rating', title: 'Reviewing & Rating'),
      SubFlow(slug: 'scheduling', title: 'Scheduling'),
      SubFlow(slug: 'sharing', title: 'Sharing'),
    ],
  ),
];

// --- Screen builders for `built` subflows ---------------------------------
// Top-level tear-offs so the catalogue can stay `const`.

Widget _deleteAccountScreen(BuildContext context) =>
    const DeleteAccountScreen();
Widget _editProfileScreen(BuildContext context) => const HomePageScreen();
Widget _loginScreen(BuildContext context) => const LoginScreen();
Widget _logoutScreen(BuildContext context) => const LogoutScreen();
Widget _resetPasswordScreen(BuildContext context) =>
    const ResetPasswordLoginScreen();
Widget _addingToCartScreen(BuildContext context) =>
    const AddingToCartHomeScreen();
Widget _bookingScreen(BuildContext context) => const BookingHomeScreen();
Widget _orderTrackingScreen(BuildContext context) =>
    const OrderTrackingScreen();
Widget _listingScreen(BuildContext context) => const ListingHomeScreen();
Widget _purchasingScreen(BuildContext context) => const HomeScreen();
Widget _transferringScreen(BuildContext context) =>
    const TransferringHomeScreen();
Widget _subscribingUpgradingScreen(BuildContext context) =>
    const SubscribingUpgradingHomeScreen();
Widget _cancelingSubscriptionScreen(BuildContext context) =>
    const CancellingSubscriptionHomeScreen();
Widget _redeemingHomeScreen(BuildContext context) =>
    const RedeemingHomeScreen();
Widget _copyingDuplicatingHomeScreen(BuildContext context) =>
    const CopyingDuplicatingHomeScreen();
Widget _importExportHomeScreen(BuildContext context) =>
    const ImportExportHomeScreen();
Widget _uploadingDownloadingHomeScreen(BuildContext context) =>
    const UploadingDownlodingHomeScreen();

// --- Lookups -------------------------------------------------------------

AppFlow? flowBySlug(String slug) {
  for (final flow in kAllFlows) {
    if (flow.slug == slug) return flow;
  }
  return null;
}

SubFlow? subFlowBySlug(String flowSlug, String subSlug) {
  final flow = flowBySlug(flowSlug);
  if (flow == null) return null;
  for (final sub in flow.subFlows) {
    if (sub.slug == subSlug) return sub;
  }
  return null;
}
