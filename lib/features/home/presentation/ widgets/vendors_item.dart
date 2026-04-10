import 'package:flutter/material.dart';

class VendorItem extends StatelessWidget {
  const VendorItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          height: 101,
          width: 101,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/vendor.png',
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 8),


        const Text(
          "Wattpad",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF121212),
          ),
        ),

        const SizedBox(height: 4),


        Row(
          children: const [
            Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
            SizedBox(width: 4),
            Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
            SizedBox(width: 4),
            Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
            SizedBox(width: 4),
            Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
            SizedBox(width: 4),
            Icon(Icons.star_border, size: 16, color: Colors.black),
          ],
        ),
      ],
    );
  }
}