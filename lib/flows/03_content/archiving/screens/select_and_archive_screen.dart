import 'package:flutter/material.dart';

class SelectAndArchiveScreen extends StatefulWidget {
  const SelectAndArchiveScreen({super.key});

  @override
  State<SelectAndArchiveScreen> createState() => _SelectAndArchiveScreenState();
}

class _SelectAndArchiveScreenState extends State<SelectAndArchiveScreen> {
  List<String> categories = ['All', 'Tops', 'Bottoms', 'footwear', 'Full body'];
  String? selectedCategory;
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: selectedCategory == categories[index]
                              ? Border.all(color: Colors.blue, width: 3.0)
                              : null,
                        ),
                        child: Center(
                          child: Image.asset(
                            categoryImages[categories[index]]!,
                          ), // Replace with your actual item content
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
                color: selectedCategory == null ? Colors.grey : Colors.blue,
              ),
              onPressed: selectedCategory == null
                  ? null
                  : () => Navigator.pop(context, selectedCategory),
            ),
            IconButton(
              icon: selectedNavigationButton == 1
                  ? const Icon(Icons.casino_outlined, color: Colors.blue)
                  : const Icon(Icons.casino_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: selectedNavigationButton == 2
                  ? const Icon(Icons.delete_outline_rounded, color: Colors.blue)
                  : const Icon(Icons.delete_outline_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
