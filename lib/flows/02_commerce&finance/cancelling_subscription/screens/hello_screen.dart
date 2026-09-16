import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/bottom_navigation_button.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/grubhub_plus_ribbon_icon.dart';
import 'package:flutter/material.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({super.key});

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Need help?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  
                  child: Row(
                    children: [
                      GrubhubPlusRibbonIcon(size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Try Grubhub+ free for 30 days',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Name',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Email',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Password',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Payment',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Gift cards',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Donate the change',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Campus dining',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Addresses',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Phone numbers',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle tap
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Push notifications',
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.chevron_right,size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(),
    );
  }
}
