import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/custom_bottom_nav.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/delivery_header.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/order_info_section.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/order_status_card.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/product_preview.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/widgets/top_searchbar.dart';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

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
                            const DeliveryHeader(),
                        
                            const SizedBox(height: 24),
                        
                            // Product preview
                            const ProductPreview(),
                        
                            const SizedBox(height: 20),
                        
                            // Order status
                            const OrderStatusCard(),
                        
                            const SizedBox(height: 20),
                        
                            // Order info section
                            const OrderInfoSection(),
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
