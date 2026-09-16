import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/cancelling_reason_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ManageYourMembershipBottomSheet extends StatefulWidget {
  const ManageYourMembershipBottomSheet({super.key});

  @override
  State<ManageYourMembershipBottomSheet> createState() =>
      _ManageYourMembershipBottomSheetState();
}

class _ManageYourMembershipBottomSheetState
    extends State<ManageYourMembershipBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Manage Your Membership',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.yellow.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Text(
              'Member since April 2025',
              style: TextStyle(fontSize: 15, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  const Text(
                    'Edit Payment Method',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 3),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                builder: (BuildContext context) {
                  return const CancellingReasonBottomSheet();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  const Text(
                    'Cancel trial',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
