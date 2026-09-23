import 'package:enterprise_ui_playground/flows/02_commerce&finance/redeeming/screens/book_table_screen.dart';
import 'package:flutter/material.dart';

class RedeemingHomeScreen extends StatefulWidget {
  const RedeemingHomeScreen({super.key});

  @override
  State<RedeemingHomeScreen> createState() => _RedeemingHomeScreenState();
}

class _RedeemingHomeScreenState extends State<RedeemingHomeScreen> {
  // Track selected segment: true for Pre-booking, false for Walk-in
  bool isPreBookingSelected = true;

  // Custom data arrays for the enhanced offers view
  final List<Map<String, String>> preBookingOffers = [
    {
      'title': 'Early Bird Discount',
      'desc': 'Get 20% off by booking 24 hours in advance.',
    },
    {
      'title': 'Free Welcome Drink',
      'desc': 'Complimentary house beverage upon arrival.',
    },
    {
      'title': 'Chef Special Tasting',
      'desc': 'Unlock an exclusive free appetizer option.',
    },
  ];

  final List<Map<String, String>> walkInOffers = [
    {
      'title': 'Happy Hour Special',
      'desc': '1-for-1 on selected drinks between 4 PM - 7 PM.',
    },
    {
      'title': 'Quick Seating Bonus',
      'desc': '10% off bill if seated at the lounge counter.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Image Stack (Now completely outside SafeArea and Padding)
            Stack(
              children: [
                Container(
                  height:
                      450, // Increased slightly for a better hero image look behind the notch
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/torye_img.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // You can place your back button, heart icon, etc., here inside the Stack.
                // Remember to use a padding wrap inside the stack buttons to push them safely below the status bar.
                Positioned(
                  top:
                      MediaQuery.of(context).padding.top +
                      1, // Dynamic safe top padding for your icons
                  left: 15,
                  right: 15,
                  child: const SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 15),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.ios_share, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withValues(
                        alpha: 0.8,
                      ), // Slightly transparent
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Torye - Drink Dine \n& Dance",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                height: 1.2, // Adjusted for better line spacing
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .green, // Distinct green for ratings
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "4.2",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '2k ratings',
                                  style: TextStyle(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4), // Space between rows
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '8.1 km • Rajarajeshwari Nagar, Bangalore',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4), // Space between rows
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Continental, North Indian | ₹1500 for two',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ), // Space between text and buttons
                        Row(
                          children: [
                            // 1. "Open till 1AM" Status Dropdown Button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Open ',
                                    style: TextStyle(
                                      color: Colors
                                          .green, // Distinct green for "Open"
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'till 1AM',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons
                                        .keyboard_arrow_down, // Chevron dropdown arrow
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8), // Gap between items
                            // 2. Directions Icon Square Button
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons
                                    .turn_right_rounded, // Diamond turn/directions style arrow icon
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8), // Gap between items
                            // 3. Call/Phone Icon Square Button
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons
                                    .call_outlined, // Phone icon with ringing accents
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 2. Body Content (Apply the padding and layout structure here)
            SafeArea(
              top:
                  false, // Prevents safe area from adding extra space at the top since the image is handling it
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.event, color: Colors.green, size: 16),
                              const SizedBox(width: 5),
                              const Text(
                                'EVENT',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Torye - Drink Dine & Dance',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Sat 28 Nov FREE',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Book now',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  'assets/images/event_poster.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Space between the event card and the next section
                    
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Offers for you',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 1. Segmented Selector (Pre-booking vs Walk-in)
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => isPreBookingSelected = true,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isPreBookingSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          25.0,
                                        ),
                                        boxShadow: isPreBookingSelected
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.05),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Text(
                                        'Pre-booking offers',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: isPreBookingSelected
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => isPreBookingSelected = false,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !isPreBookingSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          25.0,
                                        ),
                                        boxShadow: !isPreBookingSelected
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.05),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Text(
                                        'Walk-in offers',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: !isPreBookingSelected
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 2. Enhanced Dynamic Offers List according to the toggle selection
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Column(
                              key: ValueKey<bool>(isPreBookingSelected),
                              children:
                                  (isPreBookingSelected
                                          ? preBookingOffers
                                          : walkInOffers)
                                      .map((offer) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: isPreBookingSelected
                                                ? const Color(0xFFEBF5FF)
                                                : const Color(0xFFFFF7ED),
                                            borderRadius: BorderRadius.circular(
                                              12.0,
                                            ),
                                            border: Border.all(
                                              color: isPreBookingSelected
                                                  ? const Color(0xFFBFDBFE)
                                                  : const Color(0xFFFED7AA),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                isPreBookingSelected
                                                    ? Icons
                                                          .confirmation_number_outlined
                                                    : Icons.storefront,
                                                color: isPreBookingSelected
                                                    ? Colors.blue
                                                    : Colors.orange,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      offer['title']!,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      offer['desc']!,
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                      .toList(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 3. Main Action Buttons (Book a Table & Pay Bill Now)
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E5F5),
                                    borderRadius: BorderRadius.circular(14.0),
                                    
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BookTableScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Book a table',
                                      style: TextStyle(
                                        color: Color(0xFFB45309),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF5700),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Pay bill now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
