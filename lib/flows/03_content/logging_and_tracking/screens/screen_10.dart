import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/screen_11.dart';
import 'package:flutter/material.dart';

class Screen10 extends StatefulWidget {
  const Screen10({super.key});

  @override
  State<Screen10> createState() => _Screen10State();
}

class _Screen10State extends State<Screen10> {
  final List<String> streakOptions = [
    '3 days',
    '10 days',
    '15 days',
    '30 days',
  ];

  String selectedStreak = '3 days';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                    color: index == 9 ? Colors.black87 : Colors.black26,
                  );
                }),
              ),
              const SizedBox(height: 40),

              const Text(
                'How many days do you want to\nreach with your streak?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.3,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Stoic streaks are here to motivate you to maintain consistency of practice. It\'s a key to building a lasting habit and becoming your better self.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withValues(alpha: 0.45),
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Expanded(
                child: ListView.builder(
                  itemCount: streakOptions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final option = streakOptions[index];
                    final isSelected = selectedStreak == option;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStreak = option;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.black
                                : const Color(0xFFDCDCDC),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 2,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Screen11()));
        },
        child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
