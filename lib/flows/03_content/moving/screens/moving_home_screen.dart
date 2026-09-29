import 'package:enterprise_ui_playground/flows/03_content/moving/mock_data/list_items.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/widgets/list_setting_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/flows/03_content/moving/constants/total_price.dart';
import 'package:enterprise_ui_playground/flows/03_content/moving/widgets/product_list_view.dart';

class MovingHomeScreen extends StatefulWidget {
  const MovingHomeScreen({super.key, this.initialListIndex = 0});

  final int initialListIndex;

  @override
  State<MovingHomeScreen> createState() => _MovingHomeScreenState();
}

class _MovingHomeScreenState extends State<MovingHomeScreen> {
  int _selectedIndex = 1;
  late int _activeListIndex;

  @override
  void initState() {
    super.initState();
    _activeListIndex = widget.initialListIndex;
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 1) {
      final activeList = listItems[_activeListIndex];

      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            Text(
              'Blink-it',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                Text(
                  '\$0.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeList.listName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.ios_share, color: Colors.black),
                          onPressed: () {
                            // Handle add item action
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.settings, color: Colors.black),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.5,
                              ),
                              builder: (context) =>
                                  ListSettingBottomSheet(
                                    onListCreated: (listName) {
                                      setState(() {
                                        listItems.add(
                                          ListItem(listName: listName),
                                        );
                                      });
                                    },
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${activeList.items.length} items',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '\$${calculateTotalPrice(activeList.items).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Estimated Total',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "All Items (${activeList.items.length})",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ProductListView(items: activeList.items),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shop'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My Items',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'View List'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      );
    }
    else if(_selectedIndex == 2) {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            Text(
              'List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                Text(
                  '\$0.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listItems.length,
                  itemBuilder: (context, index) {
                    final item = listItems[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _activeListIndex = index;
                                  _selectedIndex = 1;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.listName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shop'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My Items',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'View List'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      );
    }
    else if(_selectedIndex == 3) {
      return Scaffold(
        body: Center(
          child: Text('Services Screen'),
        ),
      );
    }
    else if(_selectedIndex == 4) {
      return Scaffold(
        body: Center(
          child: Text('Account Screen'),
        ),
      );
    }
    else {
      return Scaffold(
        body: Center(
          child: Text('Shop Screen'),
        ),
      );
    }
  }
}
