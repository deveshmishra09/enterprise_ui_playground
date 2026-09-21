import 'package:enterprise_ui_playground/flows/03_content/copying&dulpicating/widgets/group_order_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CopyingDuplicatingHomeScreen extends StatefulWidget {
  const CopyingDuplicatingHomeScreen({super.key});

  @override
  State<CopyingDuplicatingHomeScreen> createState() =>
      _CopyingDuplicatingHomeScreenState();
}

class _CopyingDuplicatingHomeScreenState
    extends State<CopyingDuplicatingHomeScreen> {
  bool _isGroupActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        maxHeight:
                            MediaQueryData.fromView(
                              WidgetsBinding.instance.window,
                            ).size.height *
                            0.4,
                        minHeight:
                            MediaQueryData.fromView(
                              WidgetsBinding.instance.window,
                            ).size.height *
                            0.4,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // BURRITO
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/burrito.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'BURRITO',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 72, 30, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.black12),

                      // BURRITO BOWL
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/burrito_bowl.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'BURRITO BOWL',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 72, 30, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.black12),

                      // LIFESTYLE BOWL (Digital Only)
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/lifestyle_bowl.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 72, 30, 14),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'DIGITAL ONLY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'LIFESTYLE BOWL',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 72, 30, 14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.black12),

                      // QUESADILLA (Digital Only)
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/quesadilla.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 72, 30, 14),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'DIGITAL ONLY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'QUESADILLA',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 72, 30, 14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.black12),

                      // SALAD
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/salad.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'SALAD',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 72, 30, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.black12),
                      // TACOS
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/tacos.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'TACOS',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 72, 30, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.black12),
                      // SIDES & DIPS
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'lib/flows/03_content/copying&dulpicating/assets/images/sides_dips.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'SIDES & DIPS',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 72, 30, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
