import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/screens/hello_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/perks_bag_icon.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/voucher_icon.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_subscription/widgets/yellow_car_icon.dart';
import 'package:flutter/material.dart';

class RemainderBottomSheet extends StatefulWidget {
  const RemainderBottomSheet({super.key});

  @override
  State<RemainderBottomSheet> createState() => _RemainderBottomSheetState();
}

class _RemainderBottomSheetState extends State<RemainderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 10),
              const Text(
                'You still have time to save',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your Grubhub+ trial ends on May 1, 2025. Keep your membership or lose your benefits when you cancel.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              YellowCarIcon(size: 60),
              const SizedBox(width: 10),
              Text(
                'Unlimited \$0 delivery fees',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              VoucherIcon(size: 60),
              const SizedBox(width: 10),
              Text(
                'Lower service fees',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              PerksBagIcon(size: 60),
              const SizedBox(width: 10),
              Text(
                'Access to exclusive offers',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 219, 1),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Save with Grubhub+',
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
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelloScreen(),
                      ),
                    );
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
                    'Cancel anyway',
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
