import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/widgets/document_selector.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/screens/pick_your_plan_screen.dart';
import 'package:flutter/material.dart';

class SubscribingUpgradingHomeScreen extends StatefulWidget {
  const SubscribingUpgradingHomeScreen({super.key});

  @override
  State<SubscribingUpgradingHomeScreen> createState() =>
      _SubscribingUpgradingHomeScreenState();
}

class _SubscribingUpgradingHomeScreenState
    extends State<SubscribingUpgradingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Subscribing & Upgrading',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DocumentSelector(
              primaryColor: Colors.blueAccent,
              onSelected: (index) {
                // Handle document selection
                print('Selected document index: $index');
              },
            ),
            Text(
              "You're just 3 steps away \nfrom streaming!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "First, pick your plan. Your first 7 days are free, and you can cancel or change anytime. Save over 16% off the monthly price with annual billing.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.2,
              ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PickYourPlanScreen(),
                      ),
                    );
                  },
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
    );
  }
}
