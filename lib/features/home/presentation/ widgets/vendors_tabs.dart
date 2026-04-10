import 'package:flutter/material.dart';

class VendorsTabs extends StatelessWidget {
  const VendorsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          _TabItem("All", active: true),
          _TabItem("Books"),
          _TabItem("Poems"),
          _TabItem("Special for you"),
          _TabItem("Stationary"),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String text;
  final bool active;

  const _TabItem(this.text, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: active ? Colors.black : Colors.grey,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          if (active)
            Container(
              height: 2,
              width: 16,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}