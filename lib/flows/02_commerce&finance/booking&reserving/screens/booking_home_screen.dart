import "package:enterprise_ui_playground/flows/02_commerce&finance/booking&reserving/screens/date_time_screen.dart";
import "package:flutter/material.dart";

class BookingHomeScreen extends StatefulWidget {
  const BookingHomeScreen({super.key});

  @override
  State<BookingHomeScreen> createState() => _BookingHomeScreenState();
}

class _BookingHomeScreenState extends State<BookingHomeScreen> {
  // Track the currently selected preview image index
  int _selectedImageIndex = 0;

  // Base directory path for your assets
  final String _assetPath = "lib/flows/02_commerce&finance/booking&reserving/assets/images/img";

  @override
  Widget build(BuildContext context) {
    // Dynamically generate the full paths for your 5 images
    final List<String> hotelImages = List.generate(5, (index) => "$_assetPath${index + 1}.jpg");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Featured Header Hero Image
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 520,
                  child: Image.asset(
                    hotelImages[_selectedImageIndex], // Updates dynamically on tap
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient overlay to make the back button visible over light images
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.4),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // 2. Main Page Content Card
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Metadata Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Grand Horizon Resort",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 4),
                      Text("Maldives", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),

                  // 3. Interactive Horizontal Gallery Row
                  const Text(
                    "Photos & Rooms",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotelImages.length,
                      itemBuilder: (context, index) {
                        final bool isSelected = _selectedImageIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImageIndex = index; // Swap hero image
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 110,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Colors.blueAccent : Colors.transparent,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: AssetImage(hotelImages[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                  
                  // 4. Description Paragraph
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Featuring luxury overwater bungalows, private reef access, and elite spa services. Perfect for couples, honeymoons, and peaceful structural getaways.",
                    style: TextStyle(color: Colors.black54, height: 1.5, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      
      // 5. Sticky Bottom Booking Button Panel
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Total Price", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      "\$350 / night",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DateTimeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
