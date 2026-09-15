import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class NextStepScreen extends StatefulWidget {
  const NextStepScreen({super.key});

  @override
  State<NextStepScreen> createState() => _NextStepScreenState();
}

class _NextStepScreenState extends State<NextStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Enterprise UI Playground',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Next, create an account.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Get personalized show recommendations and pick up watching on any device. ",
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
            // Navigate to the SignupScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 38, 7, 236),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Continue', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}
