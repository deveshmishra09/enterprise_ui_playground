import 'package:enterprise_ui_playground/core/navigation/subflow_reset_scope.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/screens/post_screen.dart';
import 'package:flutter/material.dart';

class ListingPostModel {
  final String title;
  final String description;
  final String price;
  final bool isFree;
  final List<String> images;
  final String authorName;
  final String neighborhood;

  ListingPostModel({
    required this.title,
    required this.description,
    required this.price,
    required this.isFree,
    required this.images,
    this.authorName = 'John Doe',
    this.neighborhood = 'Lower Allston',
  });
}

class ListingHomeScreen extends StatefulWidget {
  final Map<String, dynamic>? saleItemData;
  const ListingHomeScreen({super.key, this.saleItemData});

  @override
  State<ListingHomeScreen> createState() => _ListingHomeScreenState();
}

class _ListingHomeScreenState extends State<ListingHomeScreen> {
  Map<String, dynamic>? saleItemDetails;
  @override
  void initState() {
    super.initState();
    saleItemDetails = widget.saleItemData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Location indicator
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Center(
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Location name
            const Flexible(
              child: Text(
                'Lower Allston',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            // Dropdown arrow
            const Icon(Icons.keyboard_arrow_down, size: 16),

            const Spacer(),

            // Notification
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_outlined, size: 26),

                Positioned(
                  right: -1,
                  top: -2,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // Chat / message
            const Icon(Icons.chat_bubble_outline, size: 26),

            const SizedBox(width: 14),

            // Profile avatar
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's local news",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 440,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Publisher
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 9, 10, 7),
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 7),

                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'MassLive',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Icon(
                                              Icons.verified,
                                              size: 11,
                                              color: Colors.blueGrey,
                                            ),
                                          ],
                                        ),

                                        Text(
                                          'Local publisher · 17h',
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Headline
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Biotech firm to lay off 150 people in '
                                'Cambridge, move manufacturing to Penn.',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 1.25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 7),

                            // Image
                            SizedBox(
                              width: double.infinity,
                              height: 220,
                              child: Image.asset(
                                'lib/flows/02_commerce&finance/listing/assets/images/layoffs.png',
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Website
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'masslive.com',
                                  style: TextStyle(
                                    fontSize: 7,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 5),

                            // Question
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      size: 15,
                                      color: Colors.indigo,
                                    ),
                                  ),

                                  const SizedBox(width: 7),

                                  const Expanded(
                                    child: Text(
                                      'How do you think the layoffs at GSK '
                                      'will impact the job market here in '
                                      'Cambridge?',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 9,
                                        height: 1.2,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),

                            // Bottom actions
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                              child: Row(
                                children: [
                                  // Like
                                  Container(
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '2',
                                          style: TextStyle(fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 7),

                                  // Comment
                                  Container(
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.chat_bubble_outline,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '1',
                                          style: TextStyle(fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Spacer(),

                                  // Share
                                  Container(
                                    width: 29,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.ios_share_outlined,
                                      size: 15,
                                      color: Colors.blueGrey,
                                    ),
                                  ),

                                  const SizedBox(width: 7),

                                  // More
                                  Container(
                                    width: 29,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.more_horiz,
                                      size: 15,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "For Sale",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading:
                        saleItemDetails != null &&
                            saleItemDetails!['additionalImage'] != null &&
                            (saleItemDetails!['additionalImage'] as List)
                                .isNotEmpty
                        ? Image.asset(
                            (saleItemDetails!['additionalImage'] as List)[0]
                                .toString(),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_outlined),

                    title: Text(saleItemDetails?['title'] ?? 'Item 1'),
                    subtitle: Text(
                      saleItemDetails?['description'] ??
                          'This is a great item for sale.',
                    ),
                    trailing: Text(saleItemDetails?['price'] ?? '\$0.00'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostScreen()),
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFF00897B),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit_note, color: Colors.white, size: 22),
              Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        height: 65,
        color: Colors.white,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomItem(
              Icons.home_outlined,
              'Home',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListingHomeScreen(),
                  ),
                );
              },
            ),
            _bottomItem(
              Icons.search,
              'Search',
              onTap: () {
                // Handle Search tap
              },
            ),

            const SizedBox(width: 60),

            _bottomItem(Icons.sell_outlined, 'For Sale'),
            _bottomItem(Icons.shopping_cart_checkout_outlined, 'Cart'),
          ],
        ),
      ),
    );
  }
}

Widget _bottomItem(IconData icon, String label, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 19, color: Colors.grey.shade700),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.grey.shade700)),
      ],
    ),
  );
}
