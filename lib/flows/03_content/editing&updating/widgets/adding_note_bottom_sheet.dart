import 'package:flutter/material.dart';

class AddingNoteBottomSheet extends StatefulWidget {
  const AddingNoteBottomSheet({super.key});

  @override
  State<AddingNoteBottomSheet> createState() => _AddingNoteBottomSheetState();
}

class _AddingNoteBottomSheetState extends State<AddingNoteBottomSheet> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Add Note',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Note',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: 'Content',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle add note action
              Navigator.pop(context, {
                'note': _noteController.text,
                'content': _contentController.text,
              }); // Close the bottom sheet
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor:
                  Theme.of(context).colorScheme.primary, // Make button full width
            ),
            child: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0)),
          ),
        ],
      ),
    );
  }
}