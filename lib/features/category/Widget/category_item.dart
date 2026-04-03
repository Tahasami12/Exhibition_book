import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/responsive.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Responsive.responsiveSpacing(context, 25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 16),
              fontWeight:
              isSelected ? FontWeight.bold : FontWeight.w500,
              color:
              isSelected ? Colors.black : Colors.grey[400],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(
              top: Responsive.responsiveSpacing(context, 4),
            ),
            height: Responsive.responsiveSpacing(context, 3),
            width: isSelected
                ? Responsive.responsiveSpacing(context, 15)
                : 0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(
                Responsive.responsiveSpacing(context, 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}