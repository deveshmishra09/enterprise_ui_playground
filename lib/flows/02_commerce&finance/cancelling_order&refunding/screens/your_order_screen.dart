import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/custom_bottom_nav.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/top_searchbar.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/commerce_management_screen.dart';
import 'package:flutter/material.dart';

class YourOrderScreen extends StatefulWidget {
  const YourOrderScreen({super.key});

  @override
  State<YourOrderScreen> createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Determine padding based on screen width
        double horizontalPadding;
        double verticalPadding;
        double contentWidth;

        if (width < 600) {
          // Phone
          horizontalPadding = 0.0;
          verticalPadding = 0.0;
          contentWidth = double.infinity;
        } else if (width < 1024) {
          // Tablet
          horizontalPadding = 0.0;
          verticalPadding = 16.0;
          contentWidth = double.infinity;
        } else {
          // Desktop
          horizontalPadding = 0.0;
          verticalPadding = 24.0;
          contentWidth = double.infinity;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search
                    Column(children: [const TopSearchBar()]),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),

                            // Delivery header
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your Orders',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              height: 60,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              padding: const EdgeInsets.all(15),
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

                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          size: 25,
                                          color: Colors.tealAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Search all orders',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        // SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Filter',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(Icons.keyboard_arrow_right_outlined),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Divider(
                              color: Colors.grey[300],
                              thickness: 8,
                              height: 20,
                            ),

                            Text(
                              'Past three months',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                              height: 20,
                            ),

                            const SizedBox(height: 40),

                            Text(
                              "Looks like you haven't placed an order in the last 3",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'months',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "You've reached the end of your orders.",
                              style: TextStyle(fontSize: 14),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              padding: const EdgeInsets.all(15),
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
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/product.webp',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Oxizre Shaker Bottle for Protein Mixes - \nDouble Wall Stainless Steel, For...',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          const SizedBox(width: 4),
                                          Text('136'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$38.00",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CommerceManagementScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Done',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: width < 600 ? const CustomBottomNav() : null,
        );
      },
    );
  }
}
