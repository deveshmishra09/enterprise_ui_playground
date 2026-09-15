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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the PickYourPlanScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PickYourPlanScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 38, 7, 236),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
