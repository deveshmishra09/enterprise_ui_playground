import 'package:enterprise_ui_playground/flows/02_commerce&finance/booking&reserving/screens/tour_details_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool? _realEstateAgent = null;

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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    const Text(
                      'Tell us a little about yourself',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(children: [Text('First Name')]),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(children: [Text('Last Name')]),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your last name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(children: [Text('Mobile Number')]),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '+91 XXXXX-XXXXX',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Column(
                  children: [
                    Text(
                      'I authorize the hotel to call/text me including for marketing purposes.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Column(
                  children: [
                    Text(
                      'Are you currently working with real estate agent to help you buy a home?',
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _realEstateAgent,
                      onChanged: (value) {
                        setState(() {
                          _realEstateAgent = value;
                        });
                      },
                    ),
                    const Text('Yes'),

                    const SizedBox(width: 20),

                    Radio<bool>(
                      value: false,
                      groupValue: _realEstateAgent,
                      onChanged: (value) {
                        setState(() {
                          _realEstateAgent = value;
                        });
                      },
                    ),
                    const Text('No'),
                  ],
                ),

                const SizedBox(height: 30),

                Row(children: [Text('Notes (Optional)')]),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                              'Are there other times that could work for a tour? We could get you confirmed faster.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 0,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: ElevatedButton(
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
