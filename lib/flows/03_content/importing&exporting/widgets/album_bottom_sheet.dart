import 'package:flutter/material.dart';

class AlbumBottomSheet extends StatefulWidget {
  const AlbumBottomSheet({super.key});

  @override
  State<AlbumBottomSheet> createState() => _AlbumBottomSheetState();
}

final List<String> items = [
  'lib/core/mock_data/profile_images/profile_1.jpg',
  'lib/core/mock_data/profile_images/profile_2.jpg',
  'lib/core/mock_data/profile_images/profile_3.jpg',
  'lib/core/mock_data/profile_images/profile_4.jpg',
  'lib/core/mock_data/profile_images/profile_5.jpg',
  'lib/core/mock_data/profile_images/profile_6.jpg',
  'lib/core/mock_data/profile_images/profile_7.jpg',
];

class _AlbumBottomSheetState extends State<AlbumBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Text('Albums', style: Theme.of(context).textTheme.titleLarge),
                Spacer(),
              ],
            ),
            const SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      items[index],
                    ); // Return the selected image path
                  },
                  child: Container(
                    color: Colors.grey[300],
                    child: Image.asset(items[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
