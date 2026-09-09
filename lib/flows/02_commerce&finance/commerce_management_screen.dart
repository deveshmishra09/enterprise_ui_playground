import 'package:enterprise_ui_playground/app_router.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/delete_deactivate_account/screen/delete_account_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/adding_to_cart&bag/screens/adding_to_cart_home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/boopking&reserving/screens/booking_home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/cancelling_order&refunding/screens/order_tracking_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/screens/listing_home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/purchasing&ordering.dart/screens/home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/transferring_money&donating/screens/transferring_money_home_screen.dart';
import 'package:flutter/material.dart';

class CommerceManagementScreen extends StatefulWidget {
  const CommerceManagementScreen({super.key});


  @override
  State<CommerceManagementScreen> createState() => _CommerceManagementScreenState();
}

class _CommerceManagementScreenState extends State<CommerceManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Commerce & Finance Management', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
          
                final bool isPhone = width < 600;
                final bool isTablet = width >= 600 && width < 1024;
          
                double maxContentWidth;
                int crossAxisCount;
          
                if (isPhone) {
                  maxContentWidth = double.infinity;
                  crossAxisCount = 2; // 2 columns for phones
                } else if (isTablet) {
                  maxContentWidth = 750;
                  crossAxisCount = 3; // 3 columns for tablets
                } else {
                  maxContentWidth = 900;
                  crossAxisCount = 3; // 3 columns for desktop
                }
          
                double horizontalPadding = isPhone
                    ? 15
                    : isTablet
                    ? 24
                    : 32;
          
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 16,
                    ),
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1, // Adjust card height/width ratio
                      children: [
                        // Card 1: Interactive Login Navigation
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListingHomeScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.view_list, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Listing',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 2
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddingToCartHomeScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_shopping_cart, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Adding to Cart & Bag',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 3
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Purchasing & Ordering',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 4
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingHomeScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Booking & Reserving',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 5
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderTrackingScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.production_quantity_limits, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Canceling Order & Refunding',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 6
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransferringHomeScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.swap_horiz, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Transferring Money & Donating',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 7
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeleteAccountScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.card_membership, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Subscribing & Upgrading',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                        
                        // Card 8
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeleteAccountScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.unsubscribe, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Canceling Subscription',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                          
                          
                        // Card 9
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeleteAccountScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.redeem, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Redeeming',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        // Card 
                        _buildGridCard(
                          context: context,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppRouter(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Back to Enterprise UI Playground Screen',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to keep card styling clean and reusable
  Widget _buildGridCard({
    required BuildContext context,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 10,
      color: Theme.of(context).colorScheme.inversePrimary,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Padding(padding: const EdgeInsets.all(8.0), child: child),
        ),
      ),
    );
  }
}
