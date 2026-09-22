import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String imageUrl;
  final double radius;

  const ProfileImage({super.key, required this.imageUrl, required this.radius});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipOval(
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]
      )
      
    );
  }
}