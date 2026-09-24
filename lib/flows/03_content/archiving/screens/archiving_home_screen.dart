import 'package:enterprise_ui_playground/flows/03_content/archiving/screens/select_and_archive_screen.dart';
import 'package:flutter/material.dart';

class ArchivingHomeScreen extends StatefulWidget {
  const ArchivingHomeScreen({super.key});

  @override
  State<ArchivingHomeScreen> createState() => _ArchivingHomeScreenState();
}

class _ArchivingHomeScreenState extends State<ArchivingHomeScreen> {
  List<String> categories = ['All', 'Tops', 'Bottoms', 'footwear', 'Full body'];
  final Map<String, String> categoryImages = {
    'All':
        'lib/flows/03_content/archiving/assets/images/tops/crean_band_collar_overshirt.jpg',
    'Tops':
        'lib/flows/03_content/archiving/assets/images/tops/crean_band_collar_overshirt.jpg',
    'Bottoms':
        'lib/flows/03_content/archiving/assets/images/bottoms/wide_lag_jeans.jpg',
    'footwear':
        'lib/flows/03_content/archiving/assets/images/footwear/black_boot.jpg',
    'Full body':
        'lib/flows/03_content/archiving/assets/images/fullbody/black_ribbed_maxi_dress.jpg',
  };
  final List<String> archivedCategories = [];
  int selectedNavigationButton = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 247, 250),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.more_vert, color: Colors.black, size: 30.0),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 34.0,
                            backgroundColor: Colors.blue,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 35.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(Icons.bookmark, color: Colors.green),
                          ),
                          const SizedBox(width: 20.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(Icons.map, color: Colors.green),
                          ),
                          const SizedBox(width: 20.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(Icons.bar_chart, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Mr Devesh',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@mrdevesh',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '77',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Items',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            children: [
                              Text(
                                '8',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Outfits',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            children: [
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Lookbooks',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(height: 72.0, child: _buildCategoryChips()),
                const SizedBox(height: 16.0),
                if (archivedCategories.isNotEmpty) ...[
                  Row(
                    children: [
                      Text(
                        'Archived Items',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 160.0,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 140.0,
                            mainAxisSpacing: 12.0,
                          ),
                      itemCount: archivedCategories.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          categoryImages[archivedCategories[index]]!,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 30.0,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.tune,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: categoryImages
                      .length, // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Image.asset(
                          categoryImages[categories[index]]!,
                        ), // Replace with your actual item content
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectAndArchiveScreen(),
            ),
          );
          if (result != null && mounted) {
            setState(() {
              archivedCategories.add(result as String);
            });
          }
        },
        backgroundColor: Color(0xFF9ABF74),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 35.0),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: selectedNavigationButton == 0
                  ? const Icon(Icons.language, color: Colors.blue)
                  : const Icon(Icons.language),
              onPressed: () {},
            ),
            IconButton(
              icon: selectedNavigationButton == 1
                  ? const Icon(Icons.wallet, color: Colors.blue)
                  : const Icon(Icons.wallet),
              onPressed: () {},
            ),
            IconButton(
              icon: selectedNavigationButton == 2
                  ? const Icon(Icons.shopping_cart_outlined, color: Colors.blue)
                  : const Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: selectedNavigationButton == 3
                  ? const Icon(Icons.checkroom, color: Colors.blue)
                  : const Icon(Icons.checkroom),
              onPressed: () {},
            ),
            IconButton(
              icon: selectedNavigationButton == 4
                  ? const Icon(Icons.door_sliding_outlined, color: Colors.blue)
                  : const Icon(Icons.door_sliding_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Image.asset(
                    categoryImages[category]!,
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  category,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
