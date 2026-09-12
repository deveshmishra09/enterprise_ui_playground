import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/widgets/verify_password_bottom_sheet.dart';
import 'package:flutter/material.dart';

/// Shows the mock Google Play Subscription Bottom Sheet
void showGooglePlayBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => const GooglePlaySubscriptionBottomSheet(),
  );
}

class GooglePlaySubscriptionBottomSheet extends StatelessWidget {
  const GooglePlaySubscriptionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Google Play Header Strip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  // Minimalistic mock stylized multicolor play icon text representation
                  Text(
                    'Google Play',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5F6368),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF5F6368)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // 2. Product Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock Icon Container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.movie_filter,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paramount+ Essential - 1 Week Fre...',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Paramount+ | Peak Streaming',
                      style: TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // 3. Upcoming Charges Timeline Section
          const Text(
            'Upcoming charges',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline vertical layout node element
              Column(
                children: [
                  const Icon(
                    Icons.radio_button_checked,
                    size: 14,
                    color: Color(0xFF1976D2),
                  ),
                  Container(
                    width: 2,
                    height: 28,
                    color: const Color(0xFF1976D2),
                  ),
                  const Icon(
                    Icons.radio_button_off,
                    size: 14,
                    color: Color(0xFF1976D2),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Starting today',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        Text(
                          '7-day free trial',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Starting Jul 6, 2022',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$4.99/month',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '+ tax ⓘ',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF5F6368),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // 4. Subscribing on Play Bullet Details
          const Text(
            'Subscribing on Play',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildBulletItem('Cancel anytime in Subscriptions on Google Play'),
          _buildBulletItem(
            'You won\'t be charged if you cancel before Jul 6, 2022',
          ),
          _buildBulletItem(
            'We\'ll send you a reminder 2 days before your trial ends',
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 8),

          // 5. Payment Instrument Row
          InkWell(
            onTap: () {}, // Trigger alternative payment profile selector action
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              key: const ValueKey('PaymentInstrumentRow'),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'VISA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF1A1F71),
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Visa-8212',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0xFF5F6368)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // 6. Disclaimer Explanatory Text Footer
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF5F6368),
                height: 1.35,
              ),
              children: [
                const TextSpan(
                  text:
                      'Billing starts at the end of your free trial. Starting on Jul 6, 2022 you\'ll be charged \$4.99 + tax automatically every month until you cancel. Your price may change as described in the ',
                ),
                TextSpan(
                  text: 'Google Play Terms of Service',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(
                  text:
                      '. Learn how to cancel\nBy tapping "Subscribe", you accept the following Google Payments terms of service: ',
                ),
                TextSpan(
                  text: 'Privacy Notice',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ', '),
                TextSpan(
                  text: 'Terms of Service - Buyer (US)',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: '. More'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 7. Core Subscribe Call-to-Action Action Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => showVerifyPasswordBottomSheet(context), // Trigger the password verification bottom sheet
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Subscribe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5F6368),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
