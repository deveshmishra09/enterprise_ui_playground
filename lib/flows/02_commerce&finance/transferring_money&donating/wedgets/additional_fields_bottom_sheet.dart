import 'package:flutter/material.dart';

class AdditionalFieldsBottomSheet extends StatefulWidget {
  const AdditionalFieldsBottomSheet({super.key});

  @override
  State<AdditionalFieldsBottomSheet> createState() =>
      _AdditionalFieldsBottomSheetState();
}

class _AdditionalFieldsBottomSheetState
    extends State<AdditionalFieldsBottomSheet> {
  bool? isCheckedReferenceNumber = false;
  bool? isCheckedReasonForPayment = false;

  @override
  Widget build(BuildContext context) {
    final targetHeight =
        MediaQuery.of(context).size.height * 0.3; // 40% of screen height
    return Container(
      height: targetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                const Text(
                  'Additional Fields',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Column(
              children: [
                Row(
                  children: [
                    Text('Reference Number', style: TextStyle(fontSize: 18)),
                    const Spacer(),
                    Radio<bool>(
                      value: true,
                      groupValue: isCheckedReferenceNumber,
                      onChanged: (value) {
                        setState(() {
                          if (isCheckedReasonForPayment == true) {
                            isCheckedReasonForPayment = false;
                          }
                          isCheckedReferenceNumber = true;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Reason for payment', style: TextStyle(fontSize: 18)),
                    const Spacer(),
                    Radio<bool>(
                      value: true,
                      groupValue: isCheckedReasonForPayment,
                      onChanged: (value) {
                        setState(() {
                          if (isCheckedReferenceNumber == true) {
                            isCheckedReferenceNumber = false;
                          }
                          isCheckedReasonForPayment = true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle the "Done" button press
                Navigator.pop(
                  context,
                  isCheckedReferenceNumber == true
                      ? 'Reference Number'
                      : isCheckedReasonForPayment == true
                      ? 'Reason for payment'
                      : null,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(50), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
