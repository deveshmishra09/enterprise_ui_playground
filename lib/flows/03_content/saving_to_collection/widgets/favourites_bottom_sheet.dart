import 'package:enterprise_ui_playground/flows/03_content/saving_to_collection/widgets/add_to_favourites_bottom_screen.dart';
import 'package:enterprise_ui_playground/flows/03_content/saving_to_collection/widgets/notification_bottom_sheet.dart';
import 'package:flutter/material.dart';

class FavouritesBottomSheet extends StatefulWidget {
  const FavouritesBottomSheet({super.key, required this.onFavoriteAdded});

  final ValueChanged<FavoriteEntry> onFavoriteAdded;

  @override
  State<FavouritesBottomSheet> createState() => _FavouritesBottomSheetState();
}

class _FavouritesBottomSheetState extends State<FavouritesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          const SizedBox(height: 5),
          const Text(
            'Favourites',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Name, provider, reference',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Image.asset(
                  'lib/core/mock_data/profile_images/profile_3.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Bank of America',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.drag_handle,
                  size: 26,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Handle add to favourites action
                },
              ),
            ],
          ),

          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                builder: (context) {
                  return AddToFavouritesBottomScreen(
                    onFavoriteAdded: widget.onFavoriteAdded,
                  );
                },
              ); // Close the current bottom sheet
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              // Make button full width
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.black),
                const Text(
                  'Add to Favourites',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
