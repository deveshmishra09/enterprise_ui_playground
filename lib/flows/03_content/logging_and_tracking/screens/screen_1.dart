import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/logging_and_tracking_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/screen_2.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 28),
            color: Colors.black87,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoggingAndTrackingHomeScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    width: 28,
                    height: 2,
                    color: index == 0 ? Colors.black87 : Colors.black26,
                  );
                }),
              ),
                Spacer(),
                Text(
                  'Welcome to stoic.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Text(
                  'This is your first daily reflection.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  "Each day, you'll find short reflections \n designed to help your connect with your thoughts and emotions.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Screen2()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ],
                      ),
                    ),
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
