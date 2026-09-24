import 'package:enterprise_ui_playground/flows/03_content/deleting&removing/widgets/create_poll_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DeletingRemovingHomeScreen extends StatefulWidget {
  const DeletingRemovingHomeScreen({super.key});

  @override
  State<DeletingRemovingHomeScreen> createState() =>
      _DeletingRemovingHomeScreenState();
}

IconData iconName = Icons.description_sharp;
String title = '';
String description = '';
String buttonText = '';

Widget _containerCard(
  IconData iconName,
  String title,
  String description,
  String buttonText,
  void Function()? onPressed,
) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.grey[200],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconName, size: 35.0, color: Colors.yellow[700]),
        const SizedBox(height: 12.0),
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Expanded(child: Text(description)),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 241, 216, 213),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

final List<Map<String, dynamic>> containerData = [
  {
    'icon': Icons.description_sharp,
    'title': 'Note',
    'description':
        'Easily keep track of notes, ideas, and important information with our Note feature.',
    'buttonText': 'Add',
  },
  {
    'icon': Icons.brush,
    'title': 'Doodle',
    'description':
        'Draw pictures to your friends!',
    'buttonText': 'Add',
  },
  {
    'icon': Icons.poll,
    'title': 'Poll',
    'description':
        'Create polls to gather feedback from your community!',
    'buttonText': 'Add',
  },
];

class _DeletingRemovingHomeScreenState extends State<DeletingRemovingHomeScreen> {
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
                      containerData.length,
                      (index) => _containerCard(
                        containerData[index]['icon'],
                        containerData[index]['title'],
                        containerData[index]['description'],
                        containerData[index]['buttonText'],
                        () {
                          if (index == 0 && index == 1) {
                            // Navigate to Note screen
                          } else if (index == 2) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.8,
                              ),
                              builder: (BuildContext context) {
                                return const CreatePollBottomSheet();
                              },
                            );
                          }
                        },
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
