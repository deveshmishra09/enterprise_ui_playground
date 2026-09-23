import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/screens/your_order_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/cancellation_reason_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/custom_bottom_nav.dart';import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/top_searchbar.dart';
import 'package:flutter/material.dart';

class CancelItemsScreen extends StatefulWidget {
  const CancelItemsScreen({super.key});

  @override
  State<CancelItemsScreen> createState() => _CancelItemsScreenState();
}

class _CancelItemsScreenState extends State<CancelItemsScreen> {
  String _productCancellationReason = 'Cancellation reason (optional)';

  @override
  Widget build(BuildContext context) {
    final String productName =
        'HydroJug Traveler - 40 oz \n Water Bottle with Handle & \n Flip';
    final String productPrice = '\$29.99';
    final String productQuantity = '1';
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
                                    'Cancel items',
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
                              height: 180,
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
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Deselect all',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1,
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Checkbox(
                                                  value: true,
                                                  onChanged: (value) {},
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Image.asset(
                                                'assets/images/product.webp',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            productPrice,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Qty: ',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                productQuantity,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

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
                                  Text(
                                    _productCancellationReason,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const Spacer(),

                                  IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                    ),
                                    onPressed: () async {
                                      final cancellationReason =
                                          await showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (BuildContext context) {
                                              return const CancellationReasonBottomSheet();
                                            },
                                          );

                                      if (cancellationReason != null) {
                                        setState(() {
                                          _productCancellationReason =
                                              cancellationReason;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => YourOrderScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade600,
                                // minimumSize: Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Cancel checked items',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
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
