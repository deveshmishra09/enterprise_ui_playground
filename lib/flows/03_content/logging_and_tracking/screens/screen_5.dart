import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/logging_and_tracking_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/screen_6.dart';
import 'package:flutter/material.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  State<Screen5> createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    width: 28,
                    height: 2,
                    color: index == 4 ? Colors.black87 : Colors.black26,
                  );
                }),
              ),
              const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'What do you plan to do today?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 4,
                          textInputAction: TextInputAction.newline,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            hintText: 'Start writing...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                    
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                            ),
                    
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 2,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Screen6()));
        },
        child: Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
