import 'package:enterprise_ui_playground/flows/03_content/reordering/constants/week_days_name.dart';
import 'package:flutter/material.dart';

class ReorderingHomeScreen extends StatefulWidget {
  const ReorderingHomeScreen({super.key});

  @override
  State<ReorderingHomeScreen> createState() => _ReorderingHomeScreenState();
}

class _ReorderingHomeScreenState extends State<ReorderingHomeScreen> {
  // 1. Your data source
  final List<String> _items = List<String>.from(WeekDaysName.allDays);

  // 2. The reorder handling method
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      // Corrects index calculation when moving items downwards
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String targetItem = _items.removeAt(oldIndex);
      _items.insert(newIndex, targetItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
              onPressed: () {},
            ),
            Spacer(),
            const Text(
              'Reorder Items',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            Spacer(),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ReorderableListView.builder(
          itemCount: _items.length,
          onReorder: _onReorder,
          itemBuilder: (context, index) {
            final item = _items[index];
        
            return ListTile(
              // CRITICAL: Every item must have a unique key to be reorderable
              key: ValueKey(item),
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                item,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(
                Icons.drag_handle,
                size: 26,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
    );
  }
}
