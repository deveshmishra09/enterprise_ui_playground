import 'package:flutter/material.dart';

class TableBookedScreen extends StatefulWidget {
  final int? guestCount;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String? selectedOffer;
  const TableBookedScreen({
    super.key,
    this.guestCount,
    this.selectedDate,
    this.selectedTime,
    this.selectedOffer,
  });

  @override
  State<TableBookedScreen> createState() => _TableBookedScreenState();
}

class _TableBookedScreenState extends State<TableBookedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 450,
                width: double.infinity,

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.ios_share, color: Colors.grey[600]),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 48.0,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Your table is booked!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80.0),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirmed',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${widget.selectedDate?.day}/${widget.selectedDate?.month}/${widget.selectedDate?.year ?? ''}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dinner',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              widget.selectedTime ?? '',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'for ${widget.guestCount}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'guests',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Torye - Drink Dine & Dance',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text('Rajeswari Nagar, Bangalore'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.call, color: Colors.red[700]),
                            const SizedBox(width: 10),
                            Icon(Icons.location_on, color: Colors.red[700]),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey.shade400, height: 1),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF10B981),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedOffer ?? '',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 32.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Pay bill now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pay bill will be available in your booked time slot',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey.shade400, height: 1),
                    const SizedBox(height: 20),
                    Text(
                      'What to do next?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.green[700],
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Reach restaurant on the booked date and time',
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          color: Colors.green[700],
                          size: 32,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Don\'t forger to pay your bill via Swigy Dineout to avail offers',
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5), // Light grey section background
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. "View restaurant details" Button Block
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFFF3E0,
                          ), // Soft orange/peach background
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'View restaurant details',
                              style: TextStyle(
                                color: Color(0xFFE65100), // Brand orange text
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFE65100),
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE0E0E0),
                    ),

                    // 2. "Cancel Booking" Block
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Can\'t make it to the restaurant?',
                            style: TextStyle(
                              color: Color(0xFF37474F),
                              fontSize: 14.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Cancel booking',
                              style: TextStyle(
                                color: Color(0xFFE65100),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE0E0E0),
                    ),

                    // 3. "Offer terms & conditions" Block
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Offer terms & conditions',
                              style: TextStyle(
                                color: Color(0xFF263238),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF78909C),
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Color(0xFFE65100),
        ),
        child: const Text(
          'Done',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
