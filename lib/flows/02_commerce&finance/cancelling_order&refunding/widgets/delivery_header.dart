import 'package:flutter/material.dart';

class DeliveryHeader extends StatelessWidget {
  const DeliveryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            'Arriving Wednesday',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          TextButton(
            onPressed: () {
              // Handle "Track Order" button press
            },
            child: const Text(
              'See all order',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}