import 'package:enterprise_ui_playground/flows/01_account_management/account_management_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/screen/profile_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/widgets/circular_avatar.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Card(
                    color: const Color.fromARGB(255, 83, 92, 145),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                                },
                                child: const CircularAvatar(
                                imageUrl:
                                    'lib/flows/01_account_management/edit_profile/assets/images/profile.jpg',
                                radius: 40,
                              ),
                              ),
                              
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mr Adam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    'adam123@gmail.com',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),

                              const Spacer(),

                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          Row(
                            children: [
                              Text(
                                'On member since July 2025',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest orders',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.black),
                    ),
                    TextButton(onPressed: () {}, child: const Text('See all')),
                  ],
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 3,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #12345',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            Text(
                              'Delivered',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #12346',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            Text(
                              'In Progress',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.orange),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your subscriptions',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Icon(Icons.chevron_right, color: Colors.black),
                    ),
                  ],
                ),

                const SizedBox(height: 20),  

                const Spacer(),   

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AccountManagementScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Back to Account Management Screen'),
                ),          
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const HelpcenterLegalScreen()),
            // );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
