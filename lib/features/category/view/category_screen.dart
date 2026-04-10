import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import '../../home/presentation/ widgets/custom_bottom_nav.dart';
import '../Widget/books_grid_view.dart';
import '../Widget/categories_bar.dart';
import '../Widget/category_icon.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}