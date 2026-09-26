import 'package:flutter/material.dart';

class ArchieveAndFavouriteScreen extends StatefulWidget {
  final int itemsCount;
  final int outfitsCount;
  final String initialCategory;
  const ArchieveAndFavouriteScreen({
    super.key,
    required this.itemsCount,
    required this.outfitsCount,
    required this.initialCategory,
  });

  @override
  State<ArchieveAndFavouriteScreen> createState() =>
      _ArchieveAndFavouriteScreenState();
}

class _ArchieveAndFavouriteScreenState
    extends State<ArchieveAndFavouriteScreen> {
  List<String> categories = ['All', 'Tops', 'Bottoms', 'footwear', 'Full body'];
  String? selectedCategory;
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
  int selectedNavigationButton = 4;
  String? selectedImage;
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

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  List<MapEntry<String, String>> get imageEntries => categoryImages.entries
      .where(
        (entry) =>
            entry.key != 'All' &&
            (selectedCategory == 'All' || entry.key == selectedCategory),
      )
      .expand(
        (entry) =>
            entry.value.map((imagePath) => MapEntry(entry.key, imagePath)),
      )
      .toList();

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.itemsCount.toString(),
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
                                widget.outfitsCount.toString(),
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

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: imageEntries.length,
                  itemBuilder: (context, index) {
                    final imageEntry = imageEntries[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = imageEntry.key;
                          selectedImage = imageEntry.value;
                        });
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: selectedImage == imageEntry.value
                              ? Border.all(color: Colors.blue, width: 3.0)
                              : null,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(imageEntry.value, fit: BoxFit.contain),
                            _buildPriceLabel(_priceForImage(imageEntry.value)),
                          ],
                        ),
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
        color: Color(0xFF9ABF74),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.archive_outlined,
                color: selectedImage == null ? Colors.black : Colors.blue,
              ),
              onPressed: selectedImage == null
                  ? null
                  : () => Navigator.pop(context, {
                      'archived_category': selectedCategory!,
                      'archived_image': selectedImage!,
                    }),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite_outlined,
                color: selectedImage == null ? Colors.black : Colors.red,
              ),
              onPressed: selectedImage == null
                  ? null
                  : () => Navigator.pop(context, {
                      'favourite_category': selectedCategory!,
                      'favourite_image': selectedImage!,
                    }),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.black,
              ),

              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
