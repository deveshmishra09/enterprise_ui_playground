import 'package:enterprise_ui_playground/flows/03_content/moving/screens/select_items_to_move_screen.dart';
import 'package:flutter/material.dart';

class ManageItemsBottomSheet extends StatefulWidget {
  const ManageItemsBottomSheet({super.key});

  @override
  State<ManageItemsBottomSheet> createState() => _ManageItemsBottomSheetState();
}

class _ManageItemsBottomSheetState extends State<ManageItemsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              const Text(
                'Manage Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('What do you want to do?', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  color: Colors.grey[300],
                  child: InkWell(
                    onTap: () {
                      // Handle add item action
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              size: 40,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Remove items from this list',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 2,
                  color: Colors.grey[300],
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectItemsToMoveScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 40,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            textAlign: TextAlign.center,
                            'Move items to another list',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
