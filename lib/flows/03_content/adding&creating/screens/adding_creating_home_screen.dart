import 'package:enterprise_ui_playground/flows/03_content/adding&creating/screens/note_history_screen.dart';
import 'package:flutter/material.dart';

class AddingCreatingHomeScreen extends StatefulWidget {
  const AddingCreatingHomeScreen({super.key});

  @override
  State<AddingCreatingHomeScreen> createState() =>
      _AddingCreatingHomeScreenState();
}

class _AddingCreatingHomeScreenState extends State<AddingCreatingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'lib/core/mock_data/profile_images/profile_1.jpg',
                        ),
                        radius: 22.0,
                      ),
                      Spacer(),
                      const Text(
                        'Add Magnet',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Handle menu button press
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                    children: List.generate(
                      1,
                      (index) => Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.description_sharp,
                              size: 35.0,
                              color: Colors.yellow[700],
                            ),
                            const SizedBox(height: 12.0),
                            Text('Note', 
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Expanded(child: Text('Easily keep track of notes, ideas, and important information with our Note feature.')),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteHistoryScreen()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 241, 216, 213),
                                    ),
                                    child: const Text('Add', style: TextStyle(color: Colors.red)),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
