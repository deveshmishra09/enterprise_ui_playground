import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home_outlined, size: 30),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, size: 30),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, size: 30),
          ),
        ],
      ),
    );
  }
}