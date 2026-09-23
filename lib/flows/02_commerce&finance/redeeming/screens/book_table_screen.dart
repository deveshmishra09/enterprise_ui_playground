import 'package:enterprise_ui_playground/flows/02_commerce&finance/redeeming/screens/ticket_preview.dart';
import 'package:flutter/material.dart';

class BookTableScreen extends StatefulWidget {
  const BookTableScreen({super.key});

  @override
  State<BookTableScreen> createState() => _BookTableScreenState();
}

class _BookTableScreenState extends State<BookTableScreen> {
  int guestCount = 1;
  int selectedDateIndex = 0;
  List<Map<String, dynamic>> structuralDates = [];
  int? selectedTimeIndex;
  int selectedOfferIndex = 2;

  @override
  void initState() {
    super.initState();
    _populateRollingMonthData();
  }

  Widget _buildGuestSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (guestCount > 1) {
                guestCount--;
              }
            });
          },
        ),
        Text(
          '$guestCount',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              guestCount++;
            });
          },
        ),
      ],
    );
  }

  void _populateRollingMonthData() {
    final DateTime liveNow = DateTime.now();
    final List<Map<String, dynamic>> temporaryBuffer = [];
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    for (int dayOffset = 0; dayOffset < 30; dayOffset++) {
      final DateTime iterationTarget = liveNow.add(Duration(days: dayOffset));

      final String structuralDayLabel = dayOffset == 0
          ? 'Today'
          : weekDays[iterationTarget.weekday - 1];
      final String structuredDateLabel =
          '${iterationTarget.day} ${months[iterationTarget.month - 1]}';

      temporaryBuffer.add({
        'dayLabel': structuralDayLabel,
        'dateLabel': structuredDateLabel,
        'rawDateTime': iterationTarget,
        'discountTag': '20% off', // Constant active promotion layer
      });
    }

    setState(() {
      structuralDates = temporaryBuffer;
    });
  }

  Widget _buildDateSelector() {
    if (structuralDates.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: structuralDates.length,
            itemBuilder: (context, index) {
              final item = structuralDates[index];
              final isSelected = selectedDateIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // Accent Card Frame Container
                      Container(
                        width: 68,
                        height: 76,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFE07A5F)
                                : const Color(0xFFE5E7EB),
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['dayLabel']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? const Color(0xFFE07A5F)
                                    : Colors.black54,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['dateLabel']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),

                      // Floating Promotion Pill
                      Positioned(
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['discountTag']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
    );
  }

  final List<Map<String, String>> timeSlots = [
    {'time': '09:00 PM', 'discount': '20% off'},
    {'time': '09:30 PM', 'discount': '20% off'},
    {'time': '10:00 PM', 'discount': '20% off'},
    {'time': '10:30 PM', 'discount': '20% off'},
    {'time': '11:00 PM', 'discount': '20% off'},
    {'time': '11:30 PM', 'discount': '20% off'},
    {'time': '12:00 AM', 'discount': '20% off'},
    {'time': '12:30 AM', 'discount': '20% off'},
  ];

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            'Select Time Slot',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Disables inner scrolling so it works smoothly in lists
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns layout matching the image
              crossAxisSpacing: 10, // Horizontal spacing between cards
              mainAxisSpacing: 10, // Vertical spacing between rows
              childAspectRatio: 2.1, // Width-to-height scaling for slot cards
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final slot = timeSlots[index];
              final isSelected = selectedTimeIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    // Soft light blue shade for selection background, plain white for default
                    color: isSelected ? const Color(0xFFEBF5FF) : Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFFE5E7EB),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slot['time']!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color(0xFF1E3A8A)
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        slot['discount']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : Colors.black38,
                          fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildOfferTile({
    int? index,
    String? title,
    String? subtitle,
    String? greenText,
    String? seatsLeft,
  }) {
    bool isSelected = selectedOfferIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOfferIndex = index!;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Radio Icon
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.deepOrange : Colors.grey.shade400,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Texts Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
                if (greenText != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    greenText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0F9D58), // Swiggy-like green tone
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  seatsLeft!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Book table',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Torye - Dring Dine & Dance',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 228, 245),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Number of guest(s)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildGuestSelector(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'When are you visiting?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDateSelector(),
                    const SizedBox(height: 20),
                    Text(
                      'Select the time of day to see the offers',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.dark_mode_outlined,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Dinner',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '9:00 PM to 01:00 AM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTimeSelector(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 350, // Constrain width to look like a card
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFEFEFEF,
                        ), // Light gray background matching the image
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header Title
                          const Text(
                            'Booking option for 09:30 PM',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                    
                          // --- 1. ONE EXCLUSIVE SECTION ---
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // One Exclusive Header Logo row
                                Row(
                                  children: [
                                    Text(
                                      'one',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'EXCLUSIVE',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                    
                                // Exclusive Offer 1
                                _buildOfferTile(
                                  index: 0,
                                  title: 'Flat 20% Off + Free Cocktail',
                                  subtitle: 'Redeemable cover charge: ₹20/guest',
                                  greenText:
                                      'Redeem it by paying final bill via Swiggy',
                                  seatsLeft: '13 seats left',
                                ),
                                const Divider(height: 24, color: Colors.black12),
                    
                                // Exclusive Offer 2
                                _buildOfferTile(
                                  index: 1,
                                  title: 'Flat 20% Off on Total Bill',
                                  subtitle: 'Redeemable cover charge: ₹25/guest',
                                  greenText:
                                      'Redeem it by paying final bill via Swiggy',
                                  seatsLeft: '100 seats left',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                    
                          // --- 2. REGULAR OFFER SECTION ---
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'REGULAR OFFER',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildOfferTile(
                                  index: 2,
                                  title: 'Flat 10% off on total bill',
                                  subtitle: 'Cover charge: FREE',
                                  seatsLeft: '100 seats left',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                    
                          // Bottom Footer Text
                          const Center(
                            child: Text(
                              'Coupons & additional offers available during bill payment',
                              style: TextStyle(fontSize: 10, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TicketPreview(
                    guestCount: guestCount,
                    selectedDate:
                        structuralDates[selectedDateIndex]['rawDateTime'],
                    selectedTime: timeSlots[selectedTimeIndex ?? 0]['time'],
                    selectedOffer: selectedOfferIndex == 0
                      ? 'Flat 20% off on total bill'
                      : selectedOfferIndex == 1
                        ? 'Flat 15% off on total bill'
                        : 'Flat 10% off on total bill',
                  );
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Proceed',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
