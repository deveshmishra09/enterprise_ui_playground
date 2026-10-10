import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/logging_and_tracking_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/screen_10.dart';
import 'package:flutter/material.dart';

class Screen9 extends StatefulWidget {
  const Screen9({super.key});

  @override
  State<Screen9> createState() => _Screen9State();
}

class _Screen9State extends State<Screen9> {
  final List<String> weakDays = ['sat', 'sun', 'mon', 'tue', 'wed'];

  final Set<int> checkedDayIndices = {0};
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                      color: index == 8 ? Colors.black87 : Colors.black26,
                    );
                  }),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'lib/flows/03_content/logging_and_tracking/assets/images/screen_9.jpg',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  "You completed your first reflection and started a streak.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Inner work is a journey. Every question you answer, quote you read, journal page you fill, is a step closer to your wiser self.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '1 DAY STREAK',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(weakDays.length, (index) {
                              final bool isSelected = checkedDayIndices
                                  .contains(index);

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      checkedDayIndices.remove(index);
                                    } else {
                                      checkedDayIndices.add(index);
                                    }
                                  });
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // The status bubble circle
                                      Container(
                                        width: 42,
                                        height: 42,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.black87
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.black87
                                                : Colors.grey.shade400,
                                            width: 1.5,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: isSelected
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 16,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(height: 8),
                                      // The abbreviation string label
                                      Text(
                                        weakDays[index],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isSelected
                                              ? Colors.black87
                                              : Colors.grey.shade600,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Stoic streaks are motivating, but you can turn them off if you want.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'You can also hide them later in settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),

                          SizedBox(height: 20),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Screen10()),
          );
        },
        child: Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
