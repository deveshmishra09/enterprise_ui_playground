import 'package:flutter/material.dart';
// Make sure to add this package to your pubspec.yaml:
// flutter_drawing_board: ^1.0.1+2
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

class ShowDoodleBottomSheet extends StatefulWidget {
  const ShowDoodleBottomSheet({super.key});

  @override
  State<ShowDoodleBottomSheet> createState() => _ShowDoodleBottomSheetState();
}

class _ShowDoodleBottomSheetState extends State<ShowDoodleBottomSheet> {
  // Track selected color to show state changes
  Color _selectedColor = Colors.black;

  // 1. Declare the DrawingController
  final DrawingController _drawingController = DrawingController();

  @override
  void initState() {
    super.initState();
    // 2. Set the initial paint brush style options
    _drawingController.setStyle(color: _selectedColor, strokeWidth: 4.0);
  }

  @override
  void dispose() {
    // 3. Dispose controller cleanly to avoid memory leaks
    _drawingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height *
          0.85, // Takes 85% of screen height
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDF0), // Soft cream/yellowish backdrop color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      child: Column(
        children: [
          // 1. Drag Handle indicator
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 10),

          // 2. Header Control Action Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    // 4. Capture the board content drawing as an image if needed
                    // var imageBytes = await _drawingController.getImageData();
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // 3. Central Drawing Canvas Block
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                clipBehavior: Clip
                    .antiAlias, // Ensures the drawing board conforms to rounded edges
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // 5. The Actual Interactive Drawing Board Canvas
                    DrawingBoard(
                      controller: _drawingController,
                      background: Container(color: Colors.white),
                    ),

                    // Reset / Clear canvas button positioning
                    Positioned(
                      top: 15,
                      left: 15,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        child: IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            // 6. Native package command to clear drawing canvas
                            _drawingController.clear();
                          },
                        ),
                      ),
                    ),

                    // Inner Utility Menu Selector (Text, Pen, Opacity details)
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    _drawingController.undo(), // Undo Action
                                child: const Icon(
                                  Icons.undo,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () =>
                                    _drawingController.redo(), // Redo Action
                                child: const Icon(
                                  Icons.redo,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  // Switch active drawing board mode to standard Pen
                                  _drawingController.setPaintContent(
                                    SimpleLine(),
                                  );
                                },
                                child: const Icon(
                                  Icons.gesture,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  // Switch active tool style to Eraser block
                                  _drawingController.setPaintContent(Eraser());
                                },
                                child: const Icon(
                                  Icons.cleaning_services_rounded,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // 4. Color Palette Selection Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorCircle(Colors.red),
                    _buildColorCircle(Colors.green),
                    _buildColorCircle(Colors.amber),
                    _buildColorCircle(Colors.purple),
                    _buildColorCircle(Colors.blue),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildColorCircle(Colors.black),
                    const SizedBox(width: 16),
                    _buildColorCircle(Colors.grey),
                    const SizedBox(width: 16),
                    _buildColorCircle(Colors.blueGrey.shade100),
                    const SizedBox(width: 16),
                    _buildColorCircle(Colors.white, hasBorder: true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }

  // Refactored helper method to handle interactive ink picks cleanly
  Widget _buildColorCircle(Color color, {bool hasBorder = false}) {
    final bool isSelected = _selectedColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
        // 7. Dynamic update brush property settings in real-time inside the controller
        _drawingController.setStyle(color: color);
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Colors.orange, width: 3)
              : (hasBorder
                    ? Border.all(color: Colors.black26, width: 1)
                    : null),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
