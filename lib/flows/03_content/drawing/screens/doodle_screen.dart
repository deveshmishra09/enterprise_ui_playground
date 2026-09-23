import 'package:enterprise_ui_playground/flows/03_content/drawing/widgets/show_doodle_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DoodleScreen extends StatefulWidget {
  const DoodleScreen({super.key});

  @override
  State<DoodleScreen> createState() => _DoodleScreenState();
}

final List<Map<String, dynamic>> containerData = [
  {
    'icon': Icons.description_sharp,
    'title': 'Note',
    'description':
        'Easily keep track of notes, ideas, and important information with our Note feature.',
    'buttonText': 'Add',
  },
];

class _DoodleScreenState extends State<DoodleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          // Using LayoutBuilder to get the maximum height available on the screen
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                'lib/core/mock_data/profile_images/profile_1.jpg',
                              ),
                              radius: 22.0,
                            ),
                            const Spacer(),
                            const Text(
                              'Doodle',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),

                        Expanded(
                          child: Center(
                            child: const Text(
                              'Welcome to \nyour Canvas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 44.0,
                                fontWeight: FontWeight.bold,
                                height: 0.9,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20.0),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    constraints: BoxConstraints(
                                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                                    ),
                                    builder: (context) {
                                      return const ShowDoodleBottomSheet();
                                    }
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.amberAccent.shade700,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 30.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  'New Doodle',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
