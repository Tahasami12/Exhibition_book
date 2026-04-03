import 'package:flutter/material.dart';
import 'vendors_item.dart';
class VendorsGrid extends StatelessWidget {
  const VendorsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 101 / 153,
        ),
        itemBuilder: (_, i) => const VendorItem(),
      ),
    );
  }
}