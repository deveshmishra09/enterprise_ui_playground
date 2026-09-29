import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/list_items.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/widgets/create_new_list_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MoveItemsToAnotherListBottomSheet extends StatefulWidget {
  const MoveItemsToAnotherListBottomSheet({
    super.key,
    required this.selectedItems,
    required this.sourceListIndex,
  });

  final List<int> selectedItems;
  final int sourceListIndex;

  @override
  State<MoveItemsToAnotherListBottomSheet> createState() =>
      _MoveItemsToAnotherListState();
}

class _MoveItemsToAnotherListState
    extends State<MoveItemsToAnotherListBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Move Items to Another List',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                    final item = listItems[widget.sourceListIndex]
                      .items[widget.selectedItems[index]];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    builder: (BuildContext context) {
                      return CreateNewListBottomSheet(
                        selectedItems: widget.selectedItems,
                        sourceListIndex: widget.sourceListIndex,
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Colors.blue,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Create new list',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
