import 'package:flutter/material.dart';

class CancellationReasonBottomSheet extends StatefulWidget {
  const CancellationReasonBottomSheet({super.key});

  @override
  State<CancellationReasonBottomSheet> createState() =>
      _CancellationReasonBottomSheetState();
}

class _CancellationReasonBottomSheetState
    extends State<CancellationReasonBottomSheet> {
  int _selectedIndex = -1; // No selection initially

  @override
  Widget build(BuildContext context) {
    List<String> cancellationReasons = [
      'Found a better price',
      'Ordered by mistake',
      'Item will not arrive on time',
      'Changed my mind',
      'item(s) damaged or defective',
      'items no longer needed',
      'item(s) not as described',
      'item(s) arrived too late',
      'item(s) missing from order',
      'item(s) not compatible',
      'item(s) not working',
      'item(s) not as expected',
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      margin: const EdgeInsets.all(60),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          // Close button (X) on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pop(); // Close without returning a reason
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cancellationReasons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    // Pop the selected reason immediately when tapped
                    Navigator.of(context).pop(cancellationReasons[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: _selectedIndex == index
                          ? Border.all(color: Colors.blue, width: 2)
                          : Border.all(color: Colors.black12, width: 1),
                    ),
                    child: ListTile(title: Text(cancellationReasons[index])),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
