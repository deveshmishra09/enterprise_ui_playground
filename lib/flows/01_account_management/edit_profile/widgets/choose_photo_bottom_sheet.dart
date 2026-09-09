import 'package:flutter/material.dart';

class ChoosePhotoBottomSheet extends StatefulWidget {
  const ChoosePhotoBottomSheet({super.key});

  @override
  State<ChoosePhotoBottomSheet> createState() => _ChoosePhotoBottomSheetState();
}

class _ChoosePhotoBottomSheetState extends State<ChoosePhotoBottomSheet> {
  final List<String> profileImages = [
    'lib/core/mock_data/profile_images/profile_1.jpg',
    'lib/core/mock_data/profile_images/profile_2.jpg',
    'lib/core/mock_data/profile_images/profile_3.jpg',
    'lib/core/mock_data/profile_images/profile_4.jpg',
    'lib/core/mock_data/profile_images/profile_5.jpg',
    'lib/core/mock_data/profile_images/profile_6.jpg',
    'lib/core/mock_data/profile_images/profile_7.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.8,
      ),
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profileImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(profileImages[index]);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(profileImages[index]),
                        ),
                      );
                    },
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
