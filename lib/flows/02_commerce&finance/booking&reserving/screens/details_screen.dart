import 'package:enterprise_ui_playground/flows/02_commerce&finance/booking&reserving/screens/tour_details_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool? _realEstateAgent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Last Name'),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your last name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mobile Number'),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '+91 XXXXX-XXXXX',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'I authorize the hotel to call/text me including for marketing purposes.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Are you currently working with real estate agent to help you buy a home?',
                ),
                const SizedBox(height: 20),
                RadioGroup<bool>(
                  groupValue: _realEstateAgent,
                  onChanged: (value) {
                    setState(() {
                      _realEstateAgent = value;
                    });
                  },
                  child: const Row(
                    children: [
                      Radio<bool>(value: true),
                      Text('Yes'),
                      SizedBox(width: 20),
                      Radio<bool>(value: false),
                      Text('No'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Notes (Optional)'),
                ),
                const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter your notes here...',
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TourDetailsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
