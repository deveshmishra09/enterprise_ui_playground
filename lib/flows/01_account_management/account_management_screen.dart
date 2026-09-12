import 'package:enterprise_ui_playground/app_router.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/delete_deactivate_account/screen/delete_account_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/logout/screens/logout_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/screen/home_page_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/login/screens/login_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/reset_password/screens/reset_password_login_screen.dart';
import 'package:flutter/material.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});


  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Account Management'),
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Logging In',
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
                                builder: (context) => const HomePageScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Editing Profile',
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
                                builder: (context) => const ResetPasswordLoginScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_reset, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Resetting Password',
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
                                builder: (context) => const LogoutScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Logging Out',
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
                                builder: (context) => const DeleteAccountScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_forever, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Deleting & Deactivating Account',
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
