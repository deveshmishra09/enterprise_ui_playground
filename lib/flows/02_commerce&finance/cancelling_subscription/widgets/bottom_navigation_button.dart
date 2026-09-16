import 'package:flutter/material.dart';

class BottomNavigationButton extends StatefulWidget {
  const BottomNavigationButton({super.key});

  @override
  State<BottomNavigationButton> createState() => _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<BottomNavigationButton> {
  // Add a selected index state variable to keep track of clicks
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // 1. Force the layout to stay fixed when dealing with 4+ items
      type: BottomNavigationBarType.fixed, 
      
      // 2. Set colors so everything is explicitly visible
      backgroundColor: Colors.white, 
      selectedItemColor: const Color.fromARGB(255, 248, 224, 2),
      unselectedItemColor: Colors.black,
      
      // 3. Bind the state index and click handler
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: 'Offers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
    );
  }
}
