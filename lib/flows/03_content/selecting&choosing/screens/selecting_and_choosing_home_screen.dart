import 'package:enterprise_ui_playground/flows/03_content/copying&dulpicating/widgets/group_order_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/dishes_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/dishes_name_string.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/screens/nutrition_screen.dart';
import 'package:flutter/material.dart';

class SelectingAndChoosingHomeScreen extends StatefulWidget {
  const SelectingAndChoosingHomeScreen({super.key});

  @override
  State<SelectingAndChoosingHomeScreen> createState() =>
      _SelectingAndChoosingHomeScreenState();
}

class _SelectingAndChoosingHomeScreenState
    extends State<SelectingAndChoosingHomeScreen> {
  bool _isGroupActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SWIG-GYY',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 209, 86, 41),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final linkCopied = await showModalBottomSheet<bool>(
                      context: context,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        // ignore: deprecated_member_use
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      builder: (BuildContext context) {
                        return const GroupOrderBottomSheet();
                      },
                    );

                    if (mounted) {
                      if (linkCopied == true) {
                        setState(() {
                          _isGroupActive = true; // Activate group state
                        });
                      } else if (linkCopied == false) {
                        setState(() {
                          _isGroupActive = false; // Reset to default state
                        });
                      }
                    }
                  },
                  child: Row(
                    children: [
                      // Dynamic Icon based on state
                      Icon(
                        _isGroupActive ? Icons.group : Icons.group_add,
                        size: 20,
                        color: Colors.brown,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'GROUP', // Matches the singular uppercase label in the design
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DishesNameString.allDishes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NutritionScreen(
                              dishName: DishesNameString.allDishes[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Image.asset(
                                DishesImagePath.allDishesImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              DishesNameString.allDishes[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 72, 30, 14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Ensures all 5 items display properly with text labels
        currentIndex: 1, // Set the initial selected index
        selectedItemColor: const Color.fromARGB(
          255,
          145,
          54,
          5,
        ), // Matches the brown menu text color
        unselectedItemColor: const Color.fromARGB(
          255,
          72,
          30,
          14,
        ), // Matches the brown menu text color
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'MENU'),
          BottomNavigationBarItem(icon: Icon(Icons.reorder), label: 'REORDER'),
          BottomNavigationBarItem(
            icon: Icon(Icons.gif_outlined),
            label: 'REWARDS',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.scanner), label: 'SCAN'),
        ],
      ),
    );
  }
}
