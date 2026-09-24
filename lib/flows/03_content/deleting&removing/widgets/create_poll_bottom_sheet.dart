import 'package:flutter/material.dart';

class CreatePollBottomSheet extends StatefulWidget {
  const CreatePollBottomSheet({super.key});

  @override
  State<CreatePollBottomSheet> createState() => _CreatePollBottomSheetState();
}

class _CreatePollBottomSheetState extends State<CreatePollBottomSheet> {
  Color _selectedColor = Colors.black;
  final List<TextEditingController> _optionControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
              'Create a Poll',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
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
          TextField(
            style: TextStyle(color: _selectedColor),
            decoration: InputDecoration(
              labelText: 'Poll Question',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 18.0),
          Text('Options', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _optionControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _optionField(index),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              setState(() {
                _optionControllers.add(TextEditingController());
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.red),
                  const SizedBox(width: 8.0),
                  Text(
                    'Add new option',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle poll creation logic here
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
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
        width: 40.0,
        height: 40.0,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: Colors.black, width: 3.0)
                : null,
          ),
        ),
      ),
    );
  }

  Widget _optionField(int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _optionControllers[index],
              decoration: InputDecoration(
                hintText: 'Option ${index + 1}',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                if (_optionControllers.length > 1) {
                  _optionControllers.removeAt(index).dispose();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
