import 'package:flutter/material.dart';

class GroupOrderBottomSheet extends StatefulWidget {
  // 1. Add a callback to notify the home screen when the button is pressed
  const GroupOrderBottomSheet({super.key});

  @override
  State<GroupOrderBottomSheet> createState() => _GroupOrderBottomSheetState();
}

class _GroupOrderBottomSheetState extends State<GroupOrderBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
        bottom: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_box, size: 20, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'ACTIVE',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Group Order',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Invite others to join your group order.',
            style: TextStyle(fontSize: 16, color: Colors.brown),
          ),
          const Text(
            'Limit of 15 meals per order.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MOVED SNACKBAR AND STATE LOGIC TO COPY LINK BUTTON
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Link copied.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      backgroundColor: const Color.fromARGB(
                        255,
                        43,
                        14,
                        4,
                      ), // Matching dark brown tone
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).size.height -
                            120, // Adjusted positioning below header top bar
                        left: 24,
                        right: 24,
                      ),
                    ),
                  );

                  // Trigger the callback function to update the home screen icon state
                  Navigator.of(
                    context,
                  ).pop(true); // Pass true to indicate link copied
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.brown),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.copy, size: 20, color: Colors.brown),
                    SizedBox(width: 6),
                    Text(
                      'COPY LINK',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  // Handle actual native sharing here if needed later
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.brown),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.ios_share, size: 20, color: Colors.brown),
                    SizedBox(width: 6),
                    Text(
                      'SHARE LINK',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Close the bottom sheet
            },
            child: const Text(
              'CANCEL GROUP',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
