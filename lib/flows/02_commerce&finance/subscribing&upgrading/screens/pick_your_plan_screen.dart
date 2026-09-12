import 'dart:ui';

import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/screens/next_step_screen.dart';
import 'package:flutter/material.dart';

class PickYourPlanScreen extends StatefulWidget {
  const PickYourPlanScreen({super.key});

  @override
  State<PickYourPlanScreen> createState() => _PickYourPlanScreenState();
}

class _PickYourPlanScreenState extends State<PickYourPlanScreen> {
  // State management variables for pricing and selection parameters
  bool isAnnual = false;
  String selectedPlan = 'Premium'; // Default active plan matching the image
  bool _isLoading = false;

  Future<void> _handleContinue() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NextStepScreen(),
      ),
    );
  }

  // List of premium plan feature bullet point lines matching your screen capture
  final List<String> premiumPlanFeatures = [
    'Tens of thousands of episodes & movies',
    'NFL on CBS live',
    'Top soccer plus even MORE live sports',
    'No ads except live TV & a few shows',
    '24/7 live news with CBSN',
    'Your local CBS station live',
    'Download your shows to watch later',
  ];

  // List of Essential plan feature bullet point lines matching your screen capture
  final List<String> essentialPlanFeatures = [
    'Tens of thousands of episodes & movies',
    'NFL on CBS live',
    'Top soccer like Champions League live',
    'Limited ads',
    '24/7 live news with CBSN',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildScaffold(context),
        if (_isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withValues(alpha: 0.2),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildScaffold(BuildContext context) {
    const Color brandBlue = Color(0xFF003BFB);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Back navigation
        ),
        title: const Text(
          'Pick Your Plan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 15.0,
          bottom: 100.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Try 1 week free.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Cancel Anytime',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // --- 1. Monthly / Annual Selection Toggle Pill ---
            Container(
              width: 240,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  // Monthly Option Switch Box
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isAnnual = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isAnnual
                              ? brandBlue.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(21),
                          ),
                          border: !isAnnual
                              ? Border.all(color: brandBlue, width: 2)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                            color: !isAnnual ? brandBlue : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Annual Option Switch Box
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isAnnual = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isAnnual
                              ? brandBlue.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(21),
                          ),
                          border: isAnnual
                              ? Border.all(color: brandBlue, width: 2)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Annual',
                          style: TextStyle(
                            color: isAnnual ? brandBlue : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You're saving over 16% with an annual plan!",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),

            // --- 2. Essential & Premium Comparative Matrix Cards ---
            Row(
              children: [
                // Essential Package Unit
                Expanded(
                  child: _buildPlanCard(
                    title: 'Essential',
                    price: isAnnual ? '\$49.99/year' : '\$4.99/month',
                    subtext: isAnnual ? "(That's \$4.17/month)" : 'after trial',
                    isSelected: selectedPlan == 'Essential',
                    brandColor: brandBlue,
                    onTap: () => setState(() => selectedPlan = 'Essential'),
                  ),
                ),
                const SizedBox(width: 16),
                // Premium Package Unit (Highlighted Blue in Image)
                Expanded(
                  child: _buildPlanCard(
                    title: 'Premium',
                    price: isAnnual ? '\$99.99/year' : '\$9.99/month',
                    subtext: isAnnual ? "(That's \$8.33/month)" : 'after trial',
                    isSelected: selectedPlan == 'Premium',
                    brandColor: brandBlue,
                    onTap: () => setState(() => selectedPlan = 'Premium'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // --- 3. Subscription Perks Checklist Builder Rows ---
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // The ?? 0 guard rail guarantees Flutter receives a valid number even if data is missing
              itemCount: selectedPlan == 'Essential'
                  ? essentialPlanFeatures.length
                  : premiumPlanFeatures.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                // Extra safety layer check
                if (selectedPlan == 'Essential' &&
                    index < essentialPlanFeatures.length) {
                  return Row(
                    children: [
                      const Icon(Icons.check_circle, color: brandBlue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          essentialPlanFeatures[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                } else if (selectedPlan == 'Premium' &&
                    index < premiumPlanFeatures.length) {
                  return Row(
                    children: [
                      const Icon(Icons.check_circle, color: brandBlue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          premiumPlanFeatures[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink(); // Fallback for safety
                }
              },
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003BFB), Color(0xFF0056FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _handleContinue,
                  style: OutlinedButton.styleFrom(
                    // backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- 4. Fixed Bottom Blue Gradient Action Call Button Panel ---
    );
  }

  // Modular helper method to build out cleaner plan options dynamically
  Widget _buildPlanCard({
    required String title,
    required String price,
    required String subtext,
    required bool isSelected,
    required Color brandColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 150,
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white,
          gradient: isSelected
              ? LinearGradient(
                  colors: [brandColor, brandColor.withValues(alpha: 0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? null
              : Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            if (!isAnnual)
              Text(
                'after trial',
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white70 : Colors.grey[600],
                ),
              ),
            const SizedBox(height: 8),
            Text(
              subtext,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
