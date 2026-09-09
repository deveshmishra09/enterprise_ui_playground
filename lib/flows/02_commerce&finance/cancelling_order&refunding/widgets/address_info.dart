import 'package:flutter/material.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          Text(
            'Address info',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 4),

          Text(
            'Sam Lee',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF397078),
              fontWeight: FontWeight.w500,
            ),
          ),

          Text(
            '1126 UNIVERSITY DR',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF397078),
              fontWeight: FontWeight.w500,
            ),
          ),

          Text(
            'MENLO PARK, CA 94025-4424',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF397078),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}