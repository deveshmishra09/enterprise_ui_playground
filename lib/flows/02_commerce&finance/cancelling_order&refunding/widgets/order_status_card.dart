import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/screens/cancel_items_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/address_info.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/order_progress.dart';
import 'package:flutter/material.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [

          const Text(
            'Ordered',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          const OrderProgress(
            currentStep: 0,
          ),

          const SizedBox(height: 28),

          // buttons
          Row(
            children: [

              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Update delivery\ninstructions',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                  ),  
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CancelItemsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Cancel order',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const AddressInfo(),
        ],
      ),
    );
  }
}