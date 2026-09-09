import 'package:flutter/material.dart';

class OrderInfoSection extends StatelessWidget {
  const OrderInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Order Info',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Divider(),

          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Text(
                      'View or Change this order',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),

          const Divider(),
        ],
      ),
    );
  }
}