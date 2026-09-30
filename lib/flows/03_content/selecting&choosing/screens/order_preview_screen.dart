import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/beans_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/drinks_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/protein_or_veggie_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/rice_imagepath.dart';
import 'package:enterprise_ui_playground/flows/03_content/selecting&choosing/constants/top_things_off_imagepath.dart';
import 'package:flutter/material.dart';

class OrderPreviewScreen extends StatefulWidget {
  const OrderPreviewScreen({
    super.key,
    required this.name,
    this.selectedNutrients = const <int, int>{},
    required this.dishName,
  });

  final String name;
  final Map<int, int> selectedNutrients;
  final String dishName;

  @override
  State<OrderPreviewScreen> createState() => _OrderPreviewScreenState();
}

class _OrderPreviewScreenState extends State<OrderPreviewScreen> {
  static const _coffee = Color(0xFF5A1E08);
  static const _caramel = Color(0xFFB4772D);
  static const _muted = Color(0xFF7A625A);

  final List<_SuggestedItem> _suggestions = const [
    _SuggestedItem(
      name: 'Chips',
      price: '\$1.90',
      imagePath: 'lib/flows/03_content/moving/mock_data/doritos.jpg',
    ),
    _SuggestedItem(
      name: 'Chips\n& Guac',
      price: '\$4.65',
      imagePath:
          'lib/flows/03_content/selecting&choosing/assets/images/top_things_off/guacamole.jpg',
    ),
    _SuggestedItem(
      name: 'Mexican\nCoca-Cola',
      price: '\$3.45',
      imagePath:
          'lib/flows/03_content/selecting&choosing/assets/images/drinks/mexican_cocacola.jpg',
    ),
  ];

  String get _displayName =>
      widget.name.trim().isEmpty ? 'Alex S' : widget.name.trim();

  List<_SelectedItem> get _selectedItems {
    final items = <_SelectedItem>[];
    _addSelectedItem(
      items,
      0,
      ProteinOrVeggieImagePath.allProteinOrVeggieNames,
      ProteinOrVeggieImagePath.allProteinOrVeggiePrices,
    );
    _addSelectedItem(items, 1, RiceImagePath.allRiceNames, const <String>[
      '\$0.00',
      '\$0.00',
      '\$0.00',
    ]);
    _addSelectedItem(items, 2, BeansImagePath.allBeansNames, const <String>[
      '\$0.00',
      '\$0.00',
      '\$0.00',
    ]);
    _addSelectedItem(
      items,
      3,
      TopThingsOffImagePath.allTopThingsOffNames,
      TopThingsOffImagePath.allTopThingsOffPrices,
    );
    _addSelectedItem(
      items,
      4,
      DrinksImagePath.allDrinksNames,
      DrinksImagePath.allDrinksPrices,
    );
    return items;
  }

  void _addSelectedItem(
    List<_SelectedItem> items,
    int nutrientIndex,
    List<String> names,
    List<String> prices,
  ) {
    final optionIndex = widget.selectedNutrients[nutrientIndex];
    if (optionIndex == null || optionIndex < 0 || optionIndex >= names.length) {
      return;
    }
    items.add(
      _SelectedItem(
        name: names[optionIndex],
        price: _parsePrice(prices[optionIndex]),
      ),
    );
  }

  String get _mealDetails {
    final drinkNames = DrinksImagePath.allDrinksNames;
    final details = _selectedItems
        .where((item) => !drinkNames.contains(item.name))
        .map((item) => item.name)
        .toList();
    if (details.isEmpty) {
      return 'Chicken with Brown Rice (Light), Black Beans, Cheese, Fresh Tomato Salsa, Guacamole, Roasted Chili-Corn Salsa, Romaine Lettuce, Sour Cream, Tomatillo-Green Chili Salsa';
    }
    return details.join(', ');
  }

  String get _drinkLine {
    for (final item in _selectedItems) {
      if (DrinksImagePath.allDrinksNames.contains(item.name)) {
        return 'with ${item.name} (${_formatPrice(item.price)})';
      }
    }
    return 'with 22 fl oz Tractor Organic Lemonade (\$2.95)';
  }

  double get _totalPrice {
    final items = _selectedItems;
    final addOns = items.isEmpty
        ? 2.75 + 2.95
        : items.fold<double>(0, (total, item) => total + item.price);
    return 8.95 + addOns;
  }

  static double _parsePrice(String value) {
    return double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
  }

  static String _formatPrice(double value) => '\$${value.toStringAsFixed(2)}';

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.chevron_left, color: _coffee, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: _BagIcon(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Row(
              children: [
                const Icon(Icons.group, color: _caramel, size: 22),
                const SizedBox(width: 5),
                Text(
                  'GROUP',
                  style: TextStyle(
                    color: _caramel,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMealSummary(),
            const SizedBox(height: 28),
            _buildRefreshButton(),
            const SizedBox(height: 34),
            const Divider(height: 1, color: Color(0xFFE6E1DE)),
            const SizedBox(height: 17),
            _buildSuggestions(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE6E1DE))),
          ),
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () => _showMessage('Payment flow coming next.'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _coffee,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'CONTINUE TO PAYMENT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 14, color: _muted),
            children: [
              const TextSpan(text: 'For: '),
              TextSpan(
                text: _displayName,
                style: const TextStyle(
                  color: _caramel,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const TextSpan(text: ' (you added)'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.dishName,
                style: const TextStyle(
                  color: _coffee,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _formatPrice(_totalPrice),
              style: const TextStyle(
                color: _coffee,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _mealDetails,
          style: const TextStyle(color: _muted, fontSize: 12, height: 1.35),
        ),
        const SizedBox(height: 12),
        Text(_drinkLine, style: const TextStyle(color: _muted, fontSize: 12)),
        const SizedBox(height: 17),
        Row(
          children: [
            _actionButton('REMOVE', () => _showMessage('Meal removed.')),
            const SizedBox(width: 25),
            _actionButton('EDIT', () => _showMessage('Edit meal selected.')),
            const SizedBox(width: 25),
            _actionButton('DUPLICATE', () => _showMessage('Meal duplicated.')),
          ],
        ),
      ],
    );
  }

  Widget _actionButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _caramel,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _showMessage('Order refreshed.'),
        icon: const Icon(Icons.refresh, size: 17),
        label: const Text('REFRESH'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _coffee,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Complete your order',
            style: TextStyle(
              color: _coffee,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _suggestions.length,
            // ignore: unnecessary_underscores
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = _suggestions[index];
              return SizedBox(
                width: 84,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () =>
                      _showMessage('${item.name.replaceAll('\n', ' ')} added.'),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 65,
                        child: Image.asset(item.imagePath, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          color: _coffee,
                          fontSize: 13,
                          height: 1.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.price,
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SuggestedItem {
  const _SuggestedItem({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final String price;
  final String imagePath;
}

class _SelectedItem {
  const _SelectedItem({required this.name, required this.price});

  final String name;
  final double price;
}

class _BagIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_bag, color: Color(0xFF5A1E08), size: 25),
        Positioned(
          top: -7,
          right: -8,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFB52C16),
              shape: BoxShape.circle,
            ),
            child: const Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
