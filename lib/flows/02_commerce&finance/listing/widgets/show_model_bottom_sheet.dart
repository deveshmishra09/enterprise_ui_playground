import 'package:enterprise_ui_playground/flows/02_commerce&finance/listing/widgets/sell_or_give_away_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ShowModelBottomSheet extends StatefulWidget {
  const ShowModelBottomSheet({super.key});

  @override
  State<ShowModelBottomSheet> createState() => _ShowModelBottomSheetState();
}

class _ShowModelBottomSheetState extends State<ShowModelBottomSheet> {
  // --- ADDED: Local state variable to hold the picked image path inside this sheet context ---
  String? _localSelectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      // White container with rounded top corners matching the image
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fits perfectly to the content size
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Top row of circular icons (@, image, location)
            Row(
              children: [
                _buildCircleIconButton(Icons.alternate_email),
                const SizedBox(width: 12),
                _buildCircleIconButton(
                  Icons.image_outlined,
                  onPressed: () async {
                    
                  },
                ),
                const SizedBox(width: 12),
                _buildCircleIconButton(Icons.location_on_outlined),
              ],
            ),
            const SizedBox(height: 20),

            // 2. Sell or give away block
            _buildActionBlock(
              icon: Icons.shopping_bag_outlined,
              text: 'Sell or give away',
              onTap: () async {
                // --- UPDATED: Pass the captured image path string into the constructor parameters ---
                final result = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SellOrGiveAwayBottomSheet(imagePath: _localSelectedImage),
                );

                // If a map of item data comes back, send it straight back up to PostScreen
                if (result != null && context.mounted) {
                  Navigator.pop(context, result);
                }
              },
            ),
            const SizedBox(height: 5),

            // 3. Create an event block
            _buildActionBlock(
              icon: Icons.calendar_month_outlined,
              text: 'Create an event',
              onTap: () {
                Navigator.pop(context, 'Create an event');
              },
            ),
            const SizedBox(height: 5),

            // 4. Poll your neighbors block
            _buildActionBlock(
              icon: Icons.poll_outlined,
              text: 'Poll your neighbors',
              onTap: () {
                Navigator.pop(context, 'Poll your neighbors');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the top small circle buttons
  Widget _buildCircleIconButton(IconData icon, {VoidCallback? onPressed}) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F6F9), // Light grey background circle
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20, color: const Color(0xFF1B2A4A)),
        onPressed: () {
          onPressed?.call();
        },
      ),
    );
  }

  // Helper widget to build the large action block rows
  Widget _buildActionBlock({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Soft card background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F8), // Soft card background color
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: const Color(0xFF1B2A4A)),
              const SizedBox(height: 6),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1B2A4A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
