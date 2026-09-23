import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/widgets/choose_photo_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/screens/category_screen.dart';
import 'package:flutter/material.dart';

class SellOrGiveAwayBottomSheet extends StatefulWidget {
  final String? imagePath;

  const SellOrGiveAwayBottomSheet({super.key, this.imagePath});

  @override
  State<SellOrGiveAwayBottomSheet> createState() =>
      _SellOrGiveAwayBottomSheetState();
}

class _SellOrGiveAwayBottomSheetState extends State<SellOrGiveAwayBottomSheet> {
  // Input Controller Fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // State flags matching your UI requirements
  bool _isFree = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String _selectedCategory = 'Select category';
  IconData _selectedCategoryIcon = Icons.apps;
  final List<String> _additionalPhotos = [];

  // Generic customized outline TextField modular component factory helper
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: const BorderSide(color: Color(0xFF1B2A4A), width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. New Custom Header AppBar Row Layout
                Row(
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF1B2A4A),
                        size: 28,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      'New listing',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2A4A),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 24),

                // 2. Photo Row Selector Grid Layout (Dynamic Visual Match & Fully Expandable)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // A. RENDER THE INITIAL PRE-SELECTED COVER IMAGE (If it exists)
                      if (widget.imagePath != null) ...[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: AssetImage(widget.imagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.4),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            alignment: Alignment.center,
                            child: const Text(
                              'Cover',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],

                      // B. RENDER ALL NEW ADDITIONAL IMAGES DYNAMICALLY AS THEY ARE ADDED
                      ..._additionalPhotos.map((imagePath) {
                        final int index = _additionalPhotos.indexOf(imagePath);
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // If there's no initial widget image path, make the very first new photo the Cover badge
                                alignment: Alignment.bottomCenter,
                                child: (widget.imagePath == null && index == 0)
                                    ? Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.4),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        alignment: Alignment.center,
                                        // child: const Text(
                                        //   'Cover',
                                        //   style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                                        // ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              // Small delete button to remove this specific image from your collection strip
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _additionalPhotos.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      // C. THE STATIC "ADD PHOTOS" CLICKABLE BUTTON BOX
                      InkWell(
                        onTap: () async {
                          final String? selectedImagePath =
                              await showModalBottomSheet<String>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    const ChoosePhotoBottomSheet(),
                              );

                          if (selectedImagePath != null) {
                            setState(() {
                              // Updates only your variables array tracker inside setState
                              _additionalPhotos.add(selectedImagePath);
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(12.0),
                        child: Ink(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F6F9),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Color(0xFF1B2A4A),
                                size: 24,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Add photos',
                                style: TextStyle(
                                  color: Color(0xFF1B2A4A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Form instruction text matching image specifications
                Text(
                  'Add up to 10 photos. Drag to reorder.',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 24),

                // 3. Form Content Section Block
                const Text(
                  'What are you selling?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2A4A),
                  ),
                ),
                const SizedBox(height: 16),

                _buildCustomTextField(
                  controller: _titleController,
                  hintText: 'Title',
                ),
                const SizedBox(height: 16),

                _buildCustomTextField(
                  controller: _descriptionController,
                  hintText: 'Describe your item',
                  maxLines: 2,
                ),
                const SizedBox(height: 20),

                // 4. Category Selector Row Selector
                InkWell(
                  onTap: () async {
                    // Standardized row-click fallback trigger helper integration
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      setState(() {
                        _selectedCategory = result['name'] ?? 'Select category';
                        _selectedCategoryIcon = result['icon'] ?? Icons.apps;
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          _selectedCategoryIcon,
                          color: const Color(0xFF1B2A4A),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _selectedCategory,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1B2A4A),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Price Configuration Workspace Node
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _isFree ? 0.4 : 1.0,
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EBF5),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: _priceController,
                            enabled: !_isFree,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Price',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xFF1B2A4A),
                                fontSize: 16,
                              ),
                              prefixText: '\$ ',
                              prefixStyle: TextStyle(
                                color: Color(0xFF1B2A4A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),

                    const Text(
                      'Free',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1B2A4A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: _isFree,
                      activeThumbColor: Colors.white,
                      activeTrackColor: const Color.fromARGB(255, 34, 105, 37),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[300],
                      onChanged: (bool value) {
                        setState(() {
                          _isFree = value;
                          if (_isFree) {
                            _priceController.clear();
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 6. Action Submission Interface Button
                ElevatedButton(
                  onPressed: () {
                    // Package data metrics payload structure back to parent widget
                    final Map<String, dynamic> itemDetails = {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'categoryIcon': _selectedCategoryIcon,
                      'isFree': _isFree,
                      'price': _isFree ? '0' : _priceController.text,
                      'additionalImage': _additionalPhotos,
                    };
                    Navigator.pop(context, itemDetails);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 34, 105, 37),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  child: const Text(
                    'Confirm Item Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
