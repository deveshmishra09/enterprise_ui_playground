import 'package:flutter/material.dart';

class FavoriteEntry {
  const FavoriteEntry({required this.beneficiaryName, required this.imagePath});

  final String beneficiaryName;
  final String imagePath;
}

class NotificationBottomSheet extends StatefulWidget {
  const NotificationBottomSheet({super.key, required this.beneficiaryName});

  final String beneficiaryName;

  @override
  State<NotificationBottomSheet> createState() =>
      _NotificationBottomSheetState();
}

const String imagePath = 'lib/core/mock_data/profile_images/profile_3.jpg';

class _NotificationBottomSheetState extends State<NotificationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(height: 30),
            Text(
              'You added "${widget.beneficiaryName}" to favorites',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              'Transfer money quickly to this card from your Favorites list.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  FavoriteEntry(
                    beneficiaryName: widget.beneficiaryName,
                    imagePath: imagePath,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color.fromARGB(255, 255, 77, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
