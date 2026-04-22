import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import 'category_item.dart';

class CategoriesBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoriesBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 24),
      ),
      child: Row(
        children: categories.map((name) {
          return GestureDetector(
            onTap: () => onCategorySelected(name),
            child: CategoryItem(
              title: name,
              isSelected: name == selectedCategory,
            ),
          );
        }).toList(),
      ),
    );
  }
}
