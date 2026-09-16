import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/offer_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CancellingReasonBottomSheet extends StatefulWidget {
  const CancellingReasonBottomSheet({super.key});

  @override
  State<CancellingReasonBottomSheet> createState() =>
      _CancellingReasonBottomSheetState();
}

class _CancellingReasonBottomSheetState
    extends State<CancellingReasonBottomSheet> {
  String? _selectedReason;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: const Text(
              'We\'re sorry to see you go',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 78,
                    color: Colors.amber[300], // Yellow calendar base
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.grey[800], // Dark "X" mark
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Benefits will end on April 2, 2025. You can always join Grubhub+ again if you change your mind.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Why are you cancelling?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          RadioListTile<String>(
            title: const Text('Switched to competitor'),
            value: 'Switched to competitor',
            // ignore: deprecated_member_use
            groupValue: _selectedReason,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
              // Handle selection
            },
          ),
          RadioListTile<String>(
            title: const Text('Something else'),
            value: 'Something else',
            // ignore: deprecated_member_use
            groupValue: _selectedReason,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
              // Handle selection
            },
          ),
          RadioListTile<String>(
            title: const Text('Didn\'t order enough'),
            value: 'Didn\'t order enough',
            // ignore: deprecated_member_use
            groupValue: _selectedReason,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
              // Handle selection
            },
          ),
          RadioListTile<String>(
            title: const Text('Not enough restaurants'),
            value: 'Not enough restaurants',
            // ignore: deprecated_member_use
            groupValue: _selectedReason,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
              // Handle selection
            },
          ),
          RadioListTile<String>(
            title: const Text('Cost of membership'),
            value: 'Cost of membership',
            // ignore: deprecated_member_use
            groupValue: _selectedReason,
            // ignore: deprecated_member_use
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
              // Handle selection
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedReason != null) {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          builder: (BuildContext context) {
                            return const OfferBottomSheet();
                          },
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedReason != null ? const Color.fromARGB(255, 243, 219, 1) : Colors.grey, // Yellow background if a reason is selected, otherwise grey
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedReason != null ? Colors.black : Colors.white, // Black text if a reason is selected, otherwise white
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Dismiss',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
