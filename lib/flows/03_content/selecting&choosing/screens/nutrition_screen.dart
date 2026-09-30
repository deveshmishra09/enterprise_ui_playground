import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/beans_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/dishes_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/drinks_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/nutrients_name_string.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/protein_or_veggie_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/rice_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/top_things_off_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/widgets/whos_this_meal_for_bottom_sheet.dart';
import 'package:flutter/material.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({
    super.key,
    required this.dishName,
    required this.dishImagePath,
  });

  final String dishName;
  final String dishImagePath;

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final Map<int, int> _selectedNutrients = <int, int>{};

  void _selectNutrient(int nutrientIndex, int optionIndex) {
    setState(() {
      _selectedNutrients[nutrientIndex] = optionIndex;
    });
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isSelected ? Colors.brown[800] : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.brown[800]! : Colors.brown[200]!,
          width: 2,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: isSelected
            ? const Icon(
                Icons.check,
                key: ValueKey('selected'),
                color: Colors.white,
                size: 19,
              )
            : const SizedBox(key: ValueKey('unselected')),
      ),
    );
  }

  BoxDecoration _nutrientCardDecoration(bool isSelected) {
    return BoxDecoration(
      color: isSelected ? Colors.orange[50] : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected ? Colors.orange[700]! : Colors.brown[100]!,
        width: isSelected ? 2 : 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.withValues(alpha: isSelected ? 0.12 : 0.05),
          blurRadius: isSelected ? 10 : 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'NUTRITION',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 214, 140, 88),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.tune,
              size: 20,
              color: const Color.fromARGB(255, 214, 140, 88),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Build your',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                        Text(
                          widget.dishName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            widget.dishImagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // PROTEIN OR VEGGIE
                Text(
                  NutrientsNameString.allNutrientsNameStrings[0],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Divider(color: Colors.brown[800], thickness: 1),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ProteinOrVeggieImagePath
                      .allProteinOrVeggieImagePaths
                      .length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedNutrients[0] == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _selectNutrient(0, index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: _nutrientCardDecoration(isSelected),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Image.asset(
                                ProteinOrVeggieImagePath
                                    .allProteinOrVeggieImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ProteinOrVeggieImagePath
                                        .allProteinOrVeggieNames[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 72, 30, 14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Wrap(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        ProteinOrVeggieImagePath
                                            .allProteinOrVeggiePrices[index],
                                      ),
                                      const Text('|'),
                                      Text(
                                        ProteinOrVeggieImagePath
                                            .allProteinOrVeggieCalories[index],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            _buildSelectionIndicator(isSelected),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // RICE
                Text(
                  NutrientsNameString.allNutrientsNameStrings[1],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Divider(color: Colors.brown[800], thickness: 1),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: RiceImagePath.allRiceImagePaths.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedNutrients[1] == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _selectNutrient(1, index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: _nutrientCardDecoration(isSelected),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Image.asset(
                                RiceImagePath.allRiceImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      RiceImagePath.allRiceNames[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 72, 30, 14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          RiceImagePath.allRiceCalories[index],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            _buildSelectionIndicator(isSelected),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // BEANS
                Text(
                  NutrientsNameString.allNutrientsNameStrings[2],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Divider(color: Colors.brown[800], thickness: 1),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: BeansImagePath.allBeansImagePaths.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedNutrients[2] == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _selectNutrient(2, index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: _nutrientCardDecoration(isSelected),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Image.asset(
                                BeansImagePath.allBeansImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      BeansImagePath.allBeansNames[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 72, 30, 14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          BeansImagePath
                                              .allBeansCalories[index],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            _buildSelectionIndicator(isSelected),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // TOP THINGS OFF
                Text(
                  NutrientsNameString.allNutrientsNameStrings[3],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Divider(color: Colors.brown[800], thickness: 1),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      TopThingsOffImagePath.allTopThingsOffImagePaths.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedNutrients[3] == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _selectNutrient(3, index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: _nutrientCardDecoration(isSelected),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Image.asset(
                                TopThingsOffImagePath
                                    .allTopThingsOffImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TopThingsOffImagePath
                                              .allTopThingsOffNames[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                              255,
                                              72,
                                              30,
                                              14,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              TopThingsOffImagePath
                                                  .allTopThingsOffPrices[index],
                                            ),
                                            const SizedBox(width: 10),
                                            Text('|'),
                                            const SizedBox(width: 10),
                                            Text(
                                              TopThingsOffImagePath
                                                  .allTopThingsOffCalories[index],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildSelectionIndicator(isSelected),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // DRINKS
                Text(
                  NutrientsNameString.allNutrientsNameStrings[4],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Divider(color: Colors.brown[800], thickness: 1),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DrinksImagePath.allDrinksImagePaths.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedNutrients[4] == index;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _selectNutrient(4, index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: _nutrientCardDecoration(isSelected),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Image.asset(
                                DrinksImagePath.allDrinksImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DrinksImagePath.allDrinksNames[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                              255,
                                              72,
                                              30,
                                              14,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              DrinksImagePath
                                                  .allDrinksPrices[index],
                                            ),
                                            const SizedBox(width: 10),
                                            Text('|'),
                                            const SizedBox(width: 10),
                                            Text(
                                              DrinksImagePath
                                                  .allDrinksCalories[index],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildSelectionIndicator(isSelected),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              builder: (BuildContext context) {
                return WhosThisMealForBottomSheet(
                  selectedNutrients: Map<int, int>.from(_selectedNutrients),
                  dishName: widget.dishName,
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[800],
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text(
            'ADD TO BAG',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
