import 'package:flutter/material.dart';

class OrderProgress extends StatelessWidget {
  final int currentStep;

  const OrderProgress({
    super.key,
    this.currentStep = 0,
  });

  final List<String> steps = const [
    'Ordered',
    'Shipped',
    'Out for delivery',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        steps.length,
        (index) {

          final isCompleted = index <= currentStep;

          return Expanded(
            child: Column(
              children: [

                Row(
                  children: [

                    if (index != 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: index <= currentStep
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),

                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? Colors.blue
                            : Colors.white,
                        border: Border.all(
                          color: isCompleted
                              ? Colors.blue
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              size: 11,
                              color: Colors.white,
                            )
                          : null,
                    ),

                    if (index != steps.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}