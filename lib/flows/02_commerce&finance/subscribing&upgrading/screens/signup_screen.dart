import 'dart:ui';

import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/screens/last_step_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isMarketingChecked = false; // Controls the checkbox state
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
        builder: (context) => const LastStepScreen(),
      ),
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Birthday',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'ZIP Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),

            const SizedBox(height: 20),

            InkWell(
              onTap: () {
                setState(() {
                  _isMarketingChecked = !_isMarketingChecked;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isMarketingChecked,
                    // Trigger the exact same toggle logic to prevent the double-toggle glitch
                    onChanged: (bool? value) {
                      setState(() {
                        _isMarketingChecked = !_isMarketingChecked;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "Yes, I would like to receive marketing communications, updates, special offers (including partner offers), and other information from the ViacomCBS family of companies.",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: _handleContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 38, 7, 236),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
