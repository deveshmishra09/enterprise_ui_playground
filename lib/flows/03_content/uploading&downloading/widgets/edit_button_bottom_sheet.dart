import 'package:enterprise_ui_playground/flows/03_content/uploading&downloading/widgets/gallery_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EditButtonBottomSheet extends StatefulWidget {
  const EditButtonBottomSheet({super.key});

  @override
  State<EditButtonBottomSheet> createState() => _EditButtonBottomSheetState();
}

class _EditButtonBottomSheetState extends State<EditButtonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final maxSheetHeight = MediaQuery.sizeOf(context).height * 0.8;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxSheetHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: ListTile(
                      title: Center(child: Text('Take photo')),
                      onTap: () {
                        // Handle edit profile action
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Center(child: Text('Choose photo')),
                      onTap: () async {
                        final selectedImage = await showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return GalleryBottomSheet();
                          },
                        );

                        if (selectedImage != null && context.mounted) {
                          Navigator.pop(context, selectedImage);
                        }
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Center(child: Text('Cancel')),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
