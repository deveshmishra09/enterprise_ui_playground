import 'package:flutter/material.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: double.infinity,
      child: Image.asset(
        'assets/images/product.webp',
        fit: BoxFit.contain,
      ),
    );
  }
}