import 'package:enterprise_ui_playground/flows/03_content/taking_photos/utils/tp_local_image_provider.dart';
import 'package:flutter/material.dart';

class TPProfileImage extends StatefulWidget {
  final String imageUrl;
  final double radius;

  const TPProfileImage({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  @override
  State<TPProfileImage> createState() => _TPProfileImageState();
}

class _TPProfileImageState extends State<TPProfileImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipOval(
              child: Image(
                image: localImageProvider(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
