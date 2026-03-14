import 'package:flutter/material.dart';

import 'category_item.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  final List<String> categories = const [
    "All", "Novels", "Self Love", "Science", "Romantic",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: categories.map((name) {
          return CategoryItem(
            title: name,
            isSelected: name == "All",
          );
        }).toList(),
      ),
    );
  }

}
