import 'package:enterprise_ui_playground/flows/03_content/editing&updating/widgets/adding_note_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/03_content/editing&updating/widgets/rename_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EditingUpdatingHomeScreen extends StatefulWidget {
  const EditingUpdatingHomeScreen({super.key});

  @override
  State<EditingUpdatingHomeScreen> createState() =>
      _EditingUpdatingHomeScreenState();
}

class _EditingUpdatingHomeScreenState extends State<EditingUpdatingHomeScreen> {
  String title = 'Note';
  String content =
      'This is the Editing & Updating Home Screen. Here you can edit and update your content.';
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface, // Note: background is deprecated in newer versions, use surface
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // ConstrainedBox forces the IntrinsicHeight to look at the screen size
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // Calculates screen height minus padding
                    minHeight: constraints.maxHeight - 32.0,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              title,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (value) async {
                                if (value == 'edit') {
                                  final result = await showModalBottomSheet<
                                    (String, Color)
                                  >(
                                    context: context,
                                    isScrollControlled: true,
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                          0.4,
                                    ),
                                    builder: (context) =>
                                        const RenameBottomSheet(),
                                  );
                                  if (result != null && mounted) {
                                    setState(() {
                                      title = result.$1;
                                      color = result.$2;
                                    });
                                  }
                                } else if (value == 'delete') {
                                  // Handle delete action
                                  setState(() {
                                    title = '';
                                    content = '';
                                  });
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: const Color.fromARGB(
                                            255,
                                            213,
                                            38,
                                            38,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: const Color.fromARGB(
                                            255,
                                            213,
                                            38,
                                            38,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Icon(
                            //   Icons.more_horiz,
                            //   color: Theme.of(context).colorScheme.primary,
                            //   size: 32.0,
                            // ),
                            const SizedBox(width: 8.0),
                            Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.primary,
                              size: 32.0,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),

                        // Expanded works inside SingleChildScrollView now because of IntrinsicHeight
                        Expanded(
                          child: GestureDetector(
                            onTap: () async{
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height *
                                          0.4,
                                ),
                                builder: (context) =>
                                    const AddingNoteBottomSheet(),
                              );
                              if(result != null && result is Map<String, String> && mounted){
                                setState(() {
                                  title = result['note'] ?? '';
                                  content = result['content'] ?? '';
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 0.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                content,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: color,
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
            );
          },
        ),
      ),
    );
  }
}
