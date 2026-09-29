import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/moving_items.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/list_items.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/screens/moving_home_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/widgets/move_items_to_another_list_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SelectItemsToMoveScreen extends StatefulWidget {
  const SelectItemsToMoveScreen({
    super.key,
    this.selectedItem,
    this.selectedItems = const <int>[],
    this.sourceListIndex = 0,
    this.targetListIndex,
    this.canMoveItems = false,
  });

  final int? selectedItem;
  final List<int> selectedItems;
  final int sourceListIndex;
  final int? targetListIndex;
  final bool canMoveItems;

  @override
  State<SelectItemsToMoveScreen> createState() =>
      _SelectItemsToMoveScreenState();
}

class _SelectItemsToMoveScreenState extends State<SelectItemsToMoveScreen> {
  final Set<int> _selectedItems = <int>{};

    List<MovingItem> get _sourceItems =>
      listItems[widget.sourceListIndex].items;

    bool get _canMove =>
      widget.canMoveItems &&
      widget.targetListIndex != null &&
      widget.targetListIndex != widget.sourceListIndex &&
      _selectedItems.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _selectedItems.addAll(
      widget.selectedItems.where(
        (index) => index >= 0 && index < _sourceItems.length,
      ),
    );
    final selectedItem = widget.selectedItem;
    if (selectedItem != null &&
        selectedItem >= 0 &&
        selectedItem < _sourceItems.length) {
      _selectedItems.add(selectedItem);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Items to Move'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alex\'s List',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_sourceItems.length} items',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: _selectedItems.isNotEmpty
                          ? () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.8,
                                ),
                                builder: (context) =>
                                    MoveItemsToAnotherListBottomSheet(
                                      selectedItems: _selectedItems.toList(),
                                      sourceListIndex: widget.sourceListIndex,
                                    ),
                              );
                            }
                          : null,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: _selectedItems.isNotEmpty
                                ? Colors.blueAccent
                                : Colors.grey[400],
                            fontWeight: _selectedItems.isNotEmpty
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Create New List',
                            style: TextStyle(
                              fontSize: 16,
                              color: _selectedItems.isNotEmpty
                                  ? Colors.blueAccent
                                  : Colors.grey[400],
                              fontWeight: _selectedItems.isNotEmpty
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade300, thickness: 1),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _sourceItems.length,
                  itemBuilder: (context, index) {
                    final item = _sourceItems[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  value: _selectedItems.contains(index),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value ?? false) {
                                        _selectedItems.add(index);
                                      } else {
                                        _selectedItems.remove(index);
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  item.imagePath,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    item.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  'Now \$${item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _canMove
              ? () {
                  final sourceItems = _sourceItems;
                  final movedItems = _selectedItems
                      .map((index) => sourceItems[index])
                      .toList();
                  final targetItems =
                      listItems[widget.targetListIndex!].items;

                  targetItems.addAll(movedItems);
                  for (final index in _selectedItems.toList()
                    ..sort((a, b) => b.compareTo(a))) {
                    sourceItems.removeAt(index);
                  }

                  setState(() {
                    _selectedItems.clear();
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => MovingHomeScreen(
                        initialListIndex: widget.targetListIndex!,
                      ),
                    ),
                    (route) => route.isFirst,
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _canMove ? Colors.blueAccent : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            'Move ${_selectedItems.length} Item(s)',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
