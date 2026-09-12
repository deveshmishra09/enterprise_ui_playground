import 'package:enterprise_ui_playground/flows/01_account_management/logout/screens/logout_home_screen.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help center',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chat with us',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const Divider(
                      height: 1,
                      color: Color.fromARGB(255, 232, 227, 227),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FAQ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text('Legal', style: Theme.of(context).textTheme.titleLarge),
                    
                    const SizedBox(height: 10),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'General Terms & conditions',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const Divider(
                      height: 1,
                      color: Color.fromARGB(255, 232, 227, 227),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terms of Use',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const Divider(
                      height: 1,
                      color: Color.fromARGB(255, 232, 227, 227),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const Divider(
                      height: 1,
                      color: Color.fromARGB(255, 232, 227, 227),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'On Group Cookie Notice',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const Divider(
                      height: 1,
                      color: Color.fromARGB(255, 232, 227, 227),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Imprint',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                    
                    const Divider(
                      height: 1,
                      color: Color.fromARGB(255, 232, 227, 227),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Open Source Licenses',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_right),
                          onPressed: () {
                            // Handle chat button logic here
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    
              Column(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.transparent,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LogoutHomeScreen()));
                    },
                    child: Text(
                      'Log out',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black),
                    ),
                  ),
    
                  const SizedBox(height: 10),
    
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Delete account',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
