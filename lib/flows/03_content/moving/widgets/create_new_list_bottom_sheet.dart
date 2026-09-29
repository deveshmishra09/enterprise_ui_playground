import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/list_items.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/screens/select_items_to_move_screen.dart';
import 'package:flutter/material.dart';

class CreateNewListBottomSheet extends StatefulWidget {
  const CreateNewListBottomSheet({
    super.key,
    required this.selectedItems,
    required this.sourceListIndex,
  });

  final List<int> selectedItems;
  final int sourceListIndex;

  @override
  State<CreateNewListBottomSheet> createState() =>
      _CreateNewListBottomSheetState();
}

class _CreateNewListBottomSheetState extends State<CreateNewListBottomSheet> {
  late final TextEditingController _listNameController = TextEditingController();

  @override
  void dispose() {
    _listNameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
              const Text(
                'Create New List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _listNameController,
                  decoration: InputDecoration(
                    labelText: 'List Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_listNameController.text.isNotEmpty) {
                    listItems.add(
                      ListItem(listName: _listNameController.text.trim()),
                    );
                    final targetListIndex = listItems.length - 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectItemsToMoveScreen(
                          selectedItems: widget.selectedItems,
                          sourceListIndex: widget.sourceListIndex,
                          targetListIndex: targetListIndex,
                          canMoveItems: true,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 48),
                  backgroundColor: _listNameController.text.isNotEmpty
                      ? Colors.blue
                      : Colors.grey,
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
