import 'package:flutter/material.dart';

class CircularAvatar extends StatefulWidget {
  final String imageUrl;
  final double radius;

  const CircularAvatar({super.key, required this.imageUrl, required this.radius});

  @override
  State<CircularAvatar> createState() => _CircularAvatarState();
}

class _CircularAvatarState extends State<CircularAvatar> {
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