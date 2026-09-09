import 'package:enterprise_ui_playground/flows/01_account_management/account_management_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/login/screens/login_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/commerce_management_screen.dart';
import 'package:flutter/material.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});


  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Enterpsise UI Playground'),
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
                                builder: (context) => const AccountManagementScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.manage_accounts_outlined, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Account Management',
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
                                builder: (context) => const CommerceManagementScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_balance, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Commerce & Finance',
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.article, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Content',
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.category, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Misc',
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'New User Experience',
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.groups, size: 30),
                              SizedBox(height: 8),
                              Text(
                                'Social',
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
