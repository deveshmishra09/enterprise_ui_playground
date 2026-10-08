import 'package:enterprise_ui_playground/flows/03_content/taking_photos/widgets/tp_gallery_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TPEditButtonBottomSheet extends StatefulWidget {
  const TPEditButtonBottomSheet({super.key});

  @override
  State<TPEditButtonBottomSheet> createState() => _TPEditButtonBottomSheetState();
}

class _TPEditButtonBottomSheetState extends State<TPEditButtonBottomSheet> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Wrapping with Material ensuring gesture detection flows down correctly
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Forces sheet to only take necessary height
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                clipBehavior: Clip.antiAlias, // Ensures tap effect stays within card boundaries
                child: ListTile(
                  title: const Center(child: Text('Take photo')),
                  onTap: () async {
                    debugPrint("Take photo button clicked!"); // Check your terminal for this!
                    try {
                      final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.front,
                        imageQuality: 80,
                      );

                      if (pickedFile != null && context.mounted) {
                        Navigator.pop(context, pickedFile.path);
                      }
                    } catch (e) {
                      debugPrint("CRITICAL CAMERA ERROR: $e");
                      // If it errors out (e.g. on simulator), close the sheet so it doesn't freeze
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  title: const Center(child: Text('Choose photo')),
                  onTap: () async {
                    final selectedImage = await showModalBottomSheet<String>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return const TPGalleryBottomSheet();
                      },
                    );

                    if (selectedImage != null && context.mounted) {
                      Navigator.pop(context, selectedImage);
                    }
                  },
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  title: const Center(child: Text('Cancel')),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
