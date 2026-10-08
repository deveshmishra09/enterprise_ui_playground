import 'dart:io';

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
                image: widget.imageUrl.startsWith('lib/')
                    ? AssetImage(widget.imageUrl)
                    : FileImage(File(widget.imageUrl)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
