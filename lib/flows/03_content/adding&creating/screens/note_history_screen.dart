import 'package:enterprise_ui_playground/flows/03_content/adding&creating/widgets/add_note_bottom_sheet.dart';
import 'package:flutter/material.dart';

class NoteHistoryScreen extends StatefulWidget {
  const NoteHistoryScreen({super.key});

  @override
  State<NoteHistoryScreen> createState() => _NoteHistoryScreenState();
}

class _NoteHistoryScreenState extends State<NoteHistoryScreen> {
  String _noteTitle = '';
  String _noteContent = '';
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
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'lib/core/mock_data/profile_images/profile_1.jpg',
                        ),
                        radius: 22.0,
                      ),
                      Spacer(),
                      const Text(
                        'Note History',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the screen
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
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
                      (index) => GestureDetector(
                        onTap: () async {
                          final result = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const AddNoteBottomSheet(),
                          );
                          if (result != null && mounted) {
                            setState(() {
                              _noteTitle = result['title'] ?? '';
                              _noteContent = result['content'] ?? '';
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _noteTitle.isNotEmpty ? _noteTitle : 'Note',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Expanded(
                                child: Text(
                                  _noteContent.isNotEmpty
                                      ? _noteContent
                                      : 'Content...',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
