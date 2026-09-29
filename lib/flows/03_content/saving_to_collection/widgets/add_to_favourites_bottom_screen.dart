import 'package:enterprise_ui_playground/flows/03_content/saving_to_collection/widgets/transfer_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/03_content/saving_to_collection/widgets/notification_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AddToFavouritesBottomScreen extends StatefulWidget {
  const AddToFavouritesBottomScreen({super.key, required this.onFavoriteAdded});

  final ValueChanged<FavoriteEntry> onFavoriteAdded;

  @override
  State<AddToFavouritesBottomScreen> createState() =>
      _AddToFavouritesBottomScreenState();
}

class _AddToFavouritesBottomScreenState
    extends State<AddToFavouritesBottomScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add to Favorites',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  builder: (context) {
                    return TransferBottomSheet(
                      onFavoriteAdded: widget.onFavoriteAdded,
                    );
                  },
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.double_arrow, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'By CLABE or card number',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                    onPressed: () {
                      // Handle add to favorites action
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                // Handle add to favorites action
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.payment, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bill payments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Water, electricity, etc.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                    onPressed: () {
                      // Handle add to favorites action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
