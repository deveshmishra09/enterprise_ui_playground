import 'package:enterprise_ui_playground/flows/03_content/archiving/screens/select_and_archive_screen.dart';
import 'package:flutter/material.dart';

class ArchivingHomeScreen extends StatefulWidget {
  const ArchivingHomeScreen({super.key});

  @override
  State<ArchivingHomeScreen> createState() => _ArchivingHomeScreenState();
}

class _ArchivingHomeScreenState extends State<ArchivingHomeScreen> {
  List<String> categories = ['All', 'Tops', 'Bottoms', 'footwear', 'Full body'];
  final Map<String, List<String>> categoryImages = {
    'All': [
      'lib/flows/03_content/archiving/assets/images/fullbody/black_ribbed_maxi_dress.jpg',
    ],
    'Tops': [
      'lib/flows/03_content/archiving/assets/images/tops/crean_band_collar_overshirt.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_1.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_2.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_3.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_4.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_5.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_6.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/top_7.jpg',
      'lib/flows/03_content/archiving/assets/images/tops/white_top.jpg',
    ],
    'Bottoms': [
      'lib/flows/03_content/archiving/assets/images/bottoms/wide_lag_jeans.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img1.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img2.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img3.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img4.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img5.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img6.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img7.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img8.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img9.jpg',
      'lib/flows/03_content/archiving/assets/images/bottoms/img10.jpg',
    ],
    'footwear': [
      'lib/flows/03_content/archiving/assets/images/footwear/black_boot.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img1.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img2.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img3.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img4.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img5.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img6.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img7.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img8.jpg',
      'lib/flows/03_content/archiving/assets/images/footwear/img9.jpg',
    ],
    'Full body': [
      'lib/flows/03_content/archiving/assets/images/fullbody/black_ribbed_maxi_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/black_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/bodycon_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/bride_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/carnival_cloth_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/cherry_red_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/formal_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/fullbody_slimsuit.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/long_mexi_bodycon_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/prom_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/red_dress.jpg',
      'lib/flows/03_content/archiving/assets/images/fullbody/wedding_dress.jpg',
    ],
  };
  final List<Map<String, String>> archivedItems = [];
  int selectedNavigationButton = 4;
  String selectedCategory = 'All';

  List<String> get visibleImages => selectedCategory == 'All'
      ? categoryImages.entries
            .where((entry) => entry.key != 'All')
            .expand((entry) => entry.value)
            .toList()
      : categoryImages[selectedCategory] ?? <String>[];

  List<Map<String, String>> get visibleArchivedItems =>
      selectedCategory == 'All'
      ? archivedItems
      : archivedItems
            .where((item) => item['category'] == selectedCategory)
            .toList();

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
                                'Mis. Div',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@misdiv',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                visibleImages.length.toString(),
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
                          Column(
                            children: [
                              Text(
                                categories.length.toString(),
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
                if (visibleArchivedItems.isNotEmpty) ...[
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
                      itemCount: visibleArchivedItems.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          visibleArchivedItems[index]['image']!,
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
                  itemCount: visibleImages.length,
                  itemBuilder: (context, index) {
                    final imagePath = visibleImages[index];
                    final isArchived = archivedItems.any(
                      (item) => item['image'] == imagePath,
                    );
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                        border: isArchived
                            ? const Border(
                                bottom: BorderSide(
                                  color: Colors.blue,
                                  width: 4.0,
                                ),
                              )
                            : null,
                      ),
                      child: Center(
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
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
              builder: (context) => SelectAndArchiveScreen(
                itemsCount: visibleImages.length,
                outfitsCount: visibleArchivedItems.length,
              ),
            ),
          );
          if (result is Map<String, String> && mounted) {
            setState(() {
              archivedItems.add(result);
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
          return GestureDetector(
            onTap: () {
              // Handle category selection
              setState(() {
                // You can implement your logic for selecting a category here
                selectedCategory = category;
              });
            },
            child: Padding(
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
                      border: Border.all(
                        color: selectedCategory == category
                            ? Colors.blue
                            : Colors.grey,
                        width: selectedCategory == category ? 3.0 : 1.0,
                      ),
                    ),
                    child: Image.asset(
                      categoryImages[category]!.first,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
