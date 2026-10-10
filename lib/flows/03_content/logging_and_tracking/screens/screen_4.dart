import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/logging_and_tracking_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/logging_and_tracking/screens/screen_5.dart';
import 'package:flutter/material.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  final List<String> selectedAreas = [
    'Work',
    'Relaxing',
    'Family',
    'Friends',
    'Date',
    'Pets',
    'Fitness',
    'Self-care',
    'Partner',
    'Reading',
    'Learning',
    'Traveling',
    'Music',
    'Gaming',
    'Shopping',
    'Good Meals',
    'Cleaning',
    'Creativity',
    'Sprituality',
    'Time Alone',
    'Helping Others',
    'Health',
  ];

  final List<IconData> selectedAreaIcons = [
    Icons.work,
    Icons.chair,
    Icons.family_restroom,
    Icons.group,
    Icons.favorite,
    Icons.pets,
    Icons.fitness_center,
    Icons.spa,
    Icons.people,
    Icons.menu_book,
    Icons.school,
    Icons.flight,
    Icons.music_note,
    Icons.sports_esports,
    Icons.shopping_bag,
    Icons.restaurant,
    Icons.cleaning_services,
    Icons.palette,
    Icons.self_improvement,
    Icons.person,
    Icons.volunteer_activism,
    Icons.medical_services,
  ];

  final List<int> _selectedIndices = [];

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    width: 28,
                    height: 2,
                    color: index == 3 ? Colors.black87 : Colors.black26,
                  );
                }),
              ),
              const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Which areas do you want to focus on today?',
                        textAlign: TextAlign.center,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Pick up to 3.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: selectedAreas.length,
                      itemBuilder: (context, index) {
                        final _isSelected = _selectedIndices.contains(index);
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (_isSelected) {
                                _selectedIndices.remove(index);
                              } else {
                                _selectedIndices.add(index);
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: _isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  selectedAreaIcons[index],
                                  size: 25,
                                  color: _isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                selectedAreas[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _selectedIndices.length >= 3 ? Colors.black : Colors.grey,
        elevation: 2,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Screen5()));
        },
        child: Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
