import 'package:flutter/material.dart';

// 1. Simple model to store icon and name data together
class CategoryItem {
  final String name;
  final IconData icon;

  const CategoryItem({required this.name, required this.icon});
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // 2. The exact list matching your design image
  final List<CategoryItem> categories =  [
    CategoryItem(name: 'Appliances', icon: Icons.blender_outlined),
    CategoryItem(name: 'Automotive', icon: Icons.directions_car_filled_outlined),
    CategoryItem(name: 'Baby & kids', icon: Icons.child_care_outlined),
    CategoryItem(name: 'Bicycles', icon: Icons.pedal_bike_outlined),
    CategoryItem(name: 'Clothing & accessories', icon: Icons.checkroom_outlined),
    CategoryItem(name: 'Electronics', icon: Icons.computer_outlined),
    CategoryItem(name: 'Furniture', icon: Icons.chair_outlined),
    CategoryItem(name: 'Garage sales', icon: Icons.storefront_outlined),
    CategoryItem(name: 'Garden', icon: Icons.local_florist_outlined),
    CategoryItem(name: 'Home decor', icon: Icons.chair_alt_outlined),
    CategoryItem(name: 'Home sales', icon: Icons.home_outlined),
    CategoryItem(name: 'In search of', icon: Icons.search_outlined),
    CategoryItem(name: 'Musical instruments', icon: Icons.music_note_outlined),
    CategoryItem(name: 'Neighbor made', icon: Icons.handyman_outlined),
    CategoryItem(name: 'Neighbor services', icon: Icons.person_outline),
    CategoryItem(name: 'Other', icon: Icons.apps),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF1B2A4A), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Category',
          style: TextStyle(
            color: Color(0xFF1B2A4A),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return ListTile(
            leading: Icon(item.icon, color: const Color(0xFF1B2A4A), size: 24),
            title: Text(
              item.name,
              style: const TextStyle(
                color: Color(0xFF1B2A4A),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            onTap: () {
              // Send the selected CategoryItem object back to the previous screen
              Navigator.pop(context, {'name': item.name, 'icon': item.icon});
            },
          );
        },
      ),
    );
  }
}
