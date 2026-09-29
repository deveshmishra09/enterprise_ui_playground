import 'package:enterprise_ui_playground/flows/03_content/saving_to_collection/widgets/notification_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TransferBottomSheet extends StatefulWidget {
  const TransferBottomSheet({super.key, required this.onFavoriteAdded});

  final ValueChanged<FavoriteEntry> onFavoriteAdded;

  @override
  State<TransferBottomSheet> createState() => _TransferBottomSheetState();
}

class _TransferBottomSheetState extends State<TransferBottomSheet> {
  TextEditingController _beneficiaryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Spacer(),
                const Text(
                  'Transfer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 77, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: Colors.white),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'By card number',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('Plata', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        hintText: 'Enter card number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
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
                  labelText: 'Benificiary Name',
                  hintText: 'Enter beneficiary name',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                ),
                controller: _beneficiaryNameController,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the current bottom sheet
                final favorite = await showModalBottomSheet<FavoriteEntry>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Material(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        child: NotificationBottomSheet(
                          beneficiaryName: _beneficiaryNameController.text,
                        ),
                      ),
                    );
                  },
                );
                if (favorite != null) {
                  widget.onFavoriteAdded(favorite);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color.fromARGB(
                  255,
                  255,
                  77,
                  1,
                ), // Set the background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Add to Favorites',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
