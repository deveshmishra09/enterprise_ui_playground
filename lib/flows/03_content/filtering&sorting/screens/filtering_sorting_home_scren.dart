import 'package:enterprise_ui_playground/flows/03_content/filtering&sorting/screens/archieve_and_favourite_screen.dart';
import 'package:flutter/material.dart';

class FilteringSortingHomeScreen extends StatefulWidget {
  const FilteringSortingHomeScreen({super.key});

  @override
  State<FilteringSortingHomeScreen> createState() =>
      _FilteringSortingHomeScreenState();
}

class _FilteringSortingHomeScreenState
    extends State<FilteringSortingHomeScreen> {
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
  final List<Map<String, String>> favouritedItems = [];
  int selectedNavigationButton = 4;
  String selectedCategory = 'All';

  List<String> get visibleImages {
    final images = selectedCategory == 'All'
        ? categoryImages.entries
              .where((entry) => entry.key != 'All')
              .expand((entry) => entry.value)
              .toList()
        : categoryImages[selectedCategory] ?? <String>[];

    if (_selectedPriceFilters.isEmpty) {
      return images;
    }

    return images.where((imagePath) {
      final price = _priceForImage(imagePath);
      return (_selectedPriceFilters.contains('low-budget') && price <= 500) ||
          (_selectedPriceFilters.contains('mid-budget') &&
              price > 500 &&
              price <= 5000) ||
          (_selectedPriceFilters.contains('high-budget') && price > 5000);
    }).toList();
  }

  int _priceForImage(String imagePath) {
    final allImages = categoryImages.entries
        .where((entry) => entry.key != 'All')
        .expand((entry) => entry.value)
        .toList();
    return int.parse(_prices[allImages.indexOf(imagePath)]);
  }

  Widget _buildPriceLabel(int price) {
    return Positioned(
      left: 8.0,
      right: 8.0,
      bottom: 8.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: Colors.white.withValues(alpha: 0.9),
        child: Text(
          '\$$price',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  List<Map<String, String>> get visibleArchivedItems =>
      selectedCategory == 'All'
      ? archivedItems
      : archivedItems
            .where((item) => item['category'] == selectedCategory)
            .toList();
  List<Map<String, String>> get visibleFavouritedItems =>
      selectedCategory == 'All'
      ? favouritedItems
      : favouritedItems
            .where((item) => item['category'] == selectedCategory)
            .toList();
  bool isFavoutireSelected = false;
  final List<String> _prices = [
    '200',
    '348',
    '500',
    '1000',
    '1500',
    '2000',
    '2500',
    '3000',
    '3500',
    '4000',
    '4500',
    '5000',
    '5500',
    '6000',
    '6500',
    '7000',
    '7500',
    '8000',
    '8500',
    '9000',
    '9500',
    '10000',
    '100',
    '150',
    '250',
    '300',
    '400',
    '450',
    '600',
    '700',
    '800',
    '900',
    '1000',
    '1100',
    '1200',
    '1300',
    '1400',
    '1500',
    '1600',
    '1700',
    '1800',
    '1900',
  ];

  final Set<String> _selectedPriceFilters = <String>{};
  bool _checkboxChangedWhileMenuOpen = false;

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
                        final imagePath = visibleArchivedItems[index]['image']!;
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(imagePath, fit: BoxFit.cover),
                              _buildPriceLabel(_priceForImage(imagePath)),
                            ],
                          ),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavoutireSelected = !isFavoutireSelected;
                        });
                      },
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          isFavoutireSelected
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavoutireSelected
                              ? Colors.red
                              : Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    GestureDetector(
                      onTap: () {
                        final RenderBox renderBox =
                            context.findRenderObject() as RenderBox;
                        final Offset offset = renderBox.localToGlobal(
                          Offset.zero,
                        );

                        showMenu<String>(
                          context: context,
                          position: RelativeRect.fromLTRB(
                            offset.dx - 120,
                            offset.dy - 200,
                            offset.dx + renderBox.size.width,
                            offset.dy,
                          ),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Colors.grey[100],
                          items: [
                            PopupMenuItem<String>(
                              value: 'low-budget',
                              child: _buildMenuItem('0 - 500', 'low-budget'),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              value: 'mid-budget',
                              child: _buildMenuItem(
                                '2500 - 5000',
                                'mid-budget',
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              value: 'high-budget',
                              child: _buildMenuItem(
                                '5000 - 10000',
                                'high-budget',
                              ),
                            ),
                          ],
                        ).then((value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            if (!_checkboxChangedWhileMenuOpen) {
                              if (_selectedPriceFilters.contains(value)) {
                                _selectedPriceFilters.remove(value);
                              } else {
                                _selectedPriceFilters.add(value);
                              }
                            }
                            _checkboxChangedWhileMenuOpen = false;
                          });
                        });
                      },
                      child: Container(
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
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                isFavoutireSelected
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                        itemCount: visibleFavouritedItems.length,
                        itemBuilder: (context, index) {
                          final imagePath =
                              visibleFavouritedItems[index]['image']!;
                          return Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(imagePath, fit: BoxFit.contain),
                                _buildPriceLabel(_priceForImage(imagePath)),
                              ],
                            ),
                          );
                        },
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                        itemCount: visibleImages.length,
                        itemBuilder: (context, index) {
                          final imagePath = visibleImages[index];
                          final imageCategory = categoryImages.entries
                              .firstWhere(
                                (entry) => entry.value.contains(imagePath),
                              )
                              .key;
                          final isArchived = archivedItems.any(
                            (item) => item['image'] == imagePath,
                          );
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArchieveAndFavouriteScreen(
                                        itemsCount: visibleImages.length,
                                        outfitsCount:
                                            visibleArchivedItems.length,
                                        initialCategory: imageCategory,
                                      ),
                                ),
                              );
                              if (result != null &&
                                  result is Map<String, String>) {
                                final archivedCategory =
                                    result['archived_category'];
                                final archivedImage = result['archived_image'];
                                final favouriteCategory =
                                    result['favourite_category'];
                                final favouriteImage =
                                    result['favourite_image'];

                                setState(() {
                                  if (archivedCategory != null &&
                                      archivedImage != null) {
                                    archivedItems.add({
                                      'category': archivedCategory,
                                      'image': archivedImage,
                                    });
                                  }
                                  if (favouriteCategory != null &&
                                      favouriteImage != null) {
                                    // Handle favouriting logic here
                                    // For example, you can add it to a favourites list
                                    favouritedItems.add({
                                      'category': favouriteCategory,
                                      'image': favouriteImage,
                                    });
                                  }
                                });
                              }
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
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
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 4.0,
                                            ),
                                            color: Colors.white.withValues(
                                              alpha: 0.9,
                                            ),
                                            child: Text(
                                              '\$${_priceForImage(imagePath)}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        onPressed: () {},
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

  Widget _buildPopUpButton(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 48.0), // Pushes the icon completely to the edge
          Icon(icon, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String label, String filterKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: _selectedPriceFilters.contains(filterKey),
            onChanged: (bool? newValue) {
              _checkboxChangedWhileMenuOpen = true;
              setState(() {
                if (newValue == true) {
                  _selectedPriceFilters.add(filterKey);
                } else {
                  _selectedPriceFilters.remove(filterKey);
                }
              });
              Navigator.of(context).pop(filterKey);
            },
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
