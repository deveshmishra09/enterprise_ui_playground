import 'package:enterprise_ui_playground/flows/02_commerce&finance/commerce_management_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final Map<String, dynamic>? saleItemData;
  const CartScreen({super.key, this.saleItemData});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, dynamic>? saleItemDetails;
  
  @override
  void initState() {
    super.initState();
    saleItemDetails = widget.saleItemData;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Image.asset(
                        (saleItemDetails!['additionalImage'] as String?) ??
                            'lib/core/mock_data/profile_images/profile_1.jpg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    
                title: Text(saleItemDetails?['title'] ?? 'Item 1'),
                subtitle: Text(saleItemDetails?['description'] ?? 'This is a great item for sale.'),
                trailing: Text(saleItemDetails?['price'] ?? '\$0.00'),
                onTap: () {
                  // Handle item tap
                },
              ),
            ),
      
            const Spacer(),   
      
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CommerceManagementScreen(),
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
    );
  }
}