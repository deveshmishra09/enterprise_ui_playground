import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/screens/enterprise_playground_dashboard_screen.dart';
import 'package:flutter/material.dart';

/// Shows the mock Google Play Subscription Bottom Sheet
void showVerifyPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => const VerifyPasswordBottomSheet(),
  );
}

class VerifyPasswordBottomSheet extends StatefulWidget {
  const VerifyPasswordBottomSheet({super.key});

  @override
  State<VerifyPasswordBottomSheet> createState() =>
      _VerifyPasswordBottomSheetState();
}

class _VerifyPasswordBottomSheetState extends State<VerifyPasswordBottomSheet> {
  bool _isRememberMeChecked = false; // Controls the checkbox state

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
          const SizedBox(height: 15),
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
                    SizedBox(height: 2),
                    Text(
                      'Visa-8212',
                      style: TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Enter your Google Account password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Column(
                children: [
                  Checkbox(
                    value: _isRememberMeChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isRememberMeChecked = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Remember me on this device',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // Handle "Forgot password?" action
                },
                child:  Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[800],
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle "Learn more" action
                },
                child:  Text(
                  'Learn more',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[800],
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => EnterprisePlaygroundDashboardScreen()));}, // Navigate to LastStepScreen on button press
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Verify',
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
}
