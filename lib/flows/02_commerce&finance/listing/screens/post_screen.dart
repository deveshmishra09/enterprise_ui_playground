import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/screens/listing_home_screen.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/widgets/show_model_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

// Best practice: Keep layout string/image hooks inside the State object class
String selectedOption = 'Anyone';
String? selectedImage;

class _PostScreenState extends State<PostScreen> {
  // Local state container variable to hold onto our item details
  Map<String, dynamic>? saleItemDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Top aligned look
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Left aligned components
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),

                    const Spacer(),

                    Container(
                      height: 40.0,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.language,
                            color: Colors.black,
                            size: 20,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            selectedOption,
                            style: const TextStyle(color: Colors.black),
                          ),

                          const SizedBox(width: 2),

                          IconButton(
                            onPressed: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    const ShowModelBottomSheet(),
                              );

                              if (result != null) {
                                setState(() {
                                  // 1. Check if the returning value is our item data package dictionary map
                                  if (result is Map<String, dynamic>) {
                                    saleItemDetails = result;
                                  }
                                  // 2. Check if the returning value is an asset image path location string
                                  else if (result.toString().contains(
                                    'lib/core/mock_data/',
                                  )) {
                                    selectedImage = result.toString();
                                  }
                                  // 3. Otherwise, treat it as a visibility group selection change string
                                  else {
                                    selectedOption = result.toString();
                                  }
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: () {
                        final Map<String, dynamic> saleItemData = {
                          'title': saleItemDetails?['title'] ?? '',
                          'description': saleItemDetails?['description'] ?? '',
                          'price': saleItemDetails?['price'] ?? '',
                          'isFree': saleItemDetails?['isFree'] ?? false,
                          'categoryIcon':
                              saleItemDetails?['categoryIcon'],
                          'additionalImage':
                              saleItemDetails?['additionalImage'],
                        };
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListingHomeScreen(saleItemData: saleItemData)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 34, 105, 37),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text('Post'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/core/mock_data/profile_images/profile_1.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Lower Allston',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    // Updates text hint automatically when an item card payload exists
                    hintText: saleItemDetails != null
                        ? 'What else should your neighbors know? Why are you selling or giving this away? (optional)'
                        : 'What\'s on your mind, neighbor?',
                    border: InputBorder
                        .none, // Transparent background styling matching original reference wireframe
                  ),
                ),

                // --- PRODUCT LISTING SUMMARY PREVIEW CONTAINER CARD ---
                if (saleItemDetails != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Profile Box Category Icon Frame
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 65,
                            height: 65,
                            color: Colors.orange.shade50,
                            child:
                                (saleItemDetails!['additionalImage'] != null &&
                                    (saleItemDetails!['additionalImage']
                                            as List)
                                        .isNotEmpty)
                                ? Image.asset(
                                    // --- FIXED HERE: Add [0] to select the first photo from the array list bundle ---
                                    (saleItemDetails!['additionalImage']
                                            as List)[0]
                                        .toString(),
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    saleItemDetails!['categoryIcon']
                                            as IconData? ??
                                        Icons.chair_outlined,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Right Summary Text Elements
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                saleItemDetails!['title'].toString().isNotEmpty
                                    ? saleItemDetails!['title']
                                    : 'No Title Provided',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B2A4A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                saleItemDetails!['isFree'] == true
                                    ? 'Free'
                                    : '\$${saleItemDetails!['price'] ?? "0"}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
