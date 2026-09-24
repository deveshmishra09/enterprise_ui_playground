import 'package:flutter/material.dart';

class RenameBottomSheet extends StatefulWidget {
  const RenameBottomSheet({super.key});

  @override
  State<RenameBottomSheet> createState() => _RenameBottomSheetState();
}

class _RenameBottomSheetState extends State<RenameBottomSheet> {
  final TextEditingController _noteController = TextEditingController();
  Color _selectedColor = Colors.black;
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
              'Rename Note',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
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
          const SizedBox(height: 11.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _colorSwatch(Colors.yellow),
              const SizedBox(width: 8.0),
              _colorSwatch(Colors.purple),
              const SizedBox(width: 8.0),
              _colorSwatch(Colors.blue),
              const SizedBox(width: 8.0),
              _colorSwatch(Colors.pink),
              const SizedBox(width: 8.0),
              _colorSwatch(Colors.orange),
              const SizedBox(width: 8.0),
              _colorSwatch(Colors.green),
              const SizedBox(width: 8.0),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle rename action
              Navigator.pop(
                context,
                (_noteController.text, _selectedColor) // Return the new name to the previous screen
              ); // Return the new name to the previous screen
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.red, // Make button full width
            ),
            child: const Text(
              'Update',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorSwatch(Color color) {
    final isSelected = _selectedColor == color;

    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        width: 44.0,
        height: 44.0,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
                    color: Colors.black,
                    width: 3.0,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
