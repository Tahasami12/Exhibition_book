import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import '../Widget/books_grid_view.dart';
import '../Widget/categories_bar.dart';
import '../Widget/category_icon.dart';

/// Category tab content.
/// Returns only the body — MainShell provides the Scaffold + BottomNav.
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CategoryIcon(),

          SizedBox(
            height: Responsive.responsiveSpacing(context, 10),
          ),

          const CategoriesBar(),

          SizedBox(
            height: Responsive.responsiveSpacing(context, 10),
          ),

          const Expanded(
            child: BooksGridView(),
          ),
        ],
      ),
    );
  }
}