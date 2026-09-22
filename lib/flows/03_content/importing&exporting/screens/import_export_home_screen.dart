import 'package:enterprise_ui_playground/flows/03_content/importing&exporting/widgets/album_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ImportExportHomeScreen extends StatefulWidget {
  const ImportExportHomeScreen({super.key});

  @override
  State<ImportExportHomeScreen> createState() => _ImportExportHomeScreenState();
}

class _ImportExportHomeScreenState extends State<ImportExportHomeScreen> {
  int _selectedIndex = 2;

  final List<String> items = [
    'lib/core/mock_data/profile_images/profile_1.jpg',
    'lib/core/mock_data/profile_images/profile_2.jpg',
    'lib/core/mock_data/profile_images/profile_3.jpg',
  ];

  Widget _buildMenuItem(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 48.0), // Pushes the icon completely to the edge
          Icon(icon, color: Colors.black),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.menu, size: 32.0, color: Colors.black),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.splitscreen,
                          size: 32.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12.0),
                        Icon(
                          Icons.movie_creation_outlined,
                          size: 32.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12.0),
                        Icon(
                          Icons.video_call_outlined,
                          size: 32.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Text(
                  'Studio',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16.0),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Sort and filter'),
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: items.length, // Updated to look at dynamic length
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey[300],
                      child: Image.asset(items[index], fit: BoxFit.cover),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final Offset offset = renderBox.localToGlobal(Offset.zero);

              showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx - 120,
                  offset.dy - 200,
                  offset.dx + renderBox.size.width,
                  offset.dy,
                ),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Colors.grey[100],
                items: [
                  PopupMenuItem<String>(
                    value: 'publish',
                    child: _buildMenuItem('Publish', Icons.auto_fix_high),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'import',
                    child: _buildMenuItem('Import', Icons.add_circle_outline),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'edit_draft',
                    child: _buildMenuItem('Edit draft', Icons.tune),
                  ),
                ],
              ).then((value) async {
                if (value == 'publish') {
                  // Handle Publish action
                } else if (value == 'import') {
                  // 4. Added explicit type mapping and await constraint
                  final String? selectedAsset = await showModalBottomSheet<String>(
                    // ignore: use_build_context_synchronously
                    context: context,
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      // ignore: use_build_context_synchronously
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    builder: (context) {
                      return const AlbumBottomSheet();
                    },
                  );

                  if (selectedAsset != null && mounted) {
                    setState(() {
                      items.add(selectedAsset);
                    });
                  }
                } else if (value == 'edit_draft') {
                  // Handle Edit Draft action
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
            child: const Icon(Icons.add),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined),
              color: _selectedIndex == 0 ? Colors.blue : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.search_outlined),
              color: _selectedIndex == 1 ? Colors.blue : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.grid_on_outlined),
              color: _selectedIndex == 2 ? Colors.blue : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.sentiment_satisfied_alt_outlined),
              color: _selectedIndex == 3 ? Colors.blue : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.layers_outlined),
              color: _selectedIndex == 4 ? Colors.blue : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
