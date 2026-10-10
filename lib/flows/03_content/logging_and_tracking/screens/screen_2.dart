import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/logging_and_tracking_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/screen_3.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  // Store the active selection state
  String _selectedRating = 'neutral'; 

  // Helper widget to reduce code duplication and handle individual button state
  Widget _buildRatingButton({
    required String ratingKey,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    final bool isSelected = _selectedRating == ratingKey;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? activeColor.withOpacity(0.2) : Colors.transparent,
      ),
      child: IconButton(
        icon: Icon(isSelected ? selectedIcon : unselectedIcon),
        color: isSelected ? activeColor : Colors.grey,
        iconSize: 35,
        onPressed: onTap,
      ),
    );
  }

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
                    color: index == 1 ? Colors.black87 : Colors.black26,
                  );
                }),
              ),
              const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'lib/flows/03_content/logging_and_tracking/assets/images/sleeping_on_bad.jpg',
                    width: 100,
                    height: 100,
                  ),
                ),
                Text(
                  'How well did you \n sleep today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 40),
                const Expanded(
                  child: Text(
                    'We ask about your sleep so you can monitor it, \nand improve its quality, since good sleep is \nessential to healthy and prosperous life. After a \nfew days you\'ll see insights and charts of your \nsleep quality on the trends page.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Last night',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Rate your sleep',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRatingButton(
                      ratingKey: 'very_dissatisfied',
                      selectedIcon: Icons.sentiment_very_dissatisfied,
                      unselectedIcon: Icons.sentiment_very_dissatisfied_outlined,
                      activeColor: Colors.red,
                      onTap: () => setState(() => _selectedRating = 'very_dissatisfied'),
                    ),
                    const SizedBox(width: 20),
                    _buildRatingButton(
                      ratingKey: 'dissatisfied',
                      selectedIcon: Icons.sentiment_dissatisfied,
                      unselectedIcon: Icons.sentiment_dissatisfied_outlined,
                      activeColor: Colors.orange,
                      onTap: () => setState(() => _selectedRating = 'dissatisfied'),
                    ),
                    const SizedBox(width: 20),
                    _buildRatingButton(
                      ratingKey: 'neutral',
                      selectedIcon: Icons.sentiment_neutral,
                      unselectedIcon: Icons.sentiment_neutral_outlined,
                      activeColor: Colors.yellow.shade700, // Made slightly darker for better contrast
                      onTap: () => setState(() => _selectedRating = 'neutral'),
                    ),
                    const SizedBox(width: 20),
                    _buildRatingButton(
                      ratingKey: 'satisfied',
                      selectedIcon: Icons.sentiment_satisfied,
                      unselectedIcon: Icons.sentiment_satisfied_outlined,
                      activeColor: Colors.lightGreen,
                      onTap: () => setState(() => _selectedRating = 'satisfied'),
                    ),
                    const SizedBox(width: 20),
                    _buildRatingButton(
                      ratingKey: 'very_satisfied',
                      selectedIcon: Icons.sentiment_very_satisfied,
                      unselectedIcon: Icons.sentiment_very_satisfied_outlined,
                      activeColor: Colors.green, // Changed from orange to green to better represent high satisfaction
                      onTap: () => setState(() => _selectedRating = 'very_satisfied'),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 2,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Screen3(selectedRating: _selectedRating )));
        },
        child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
