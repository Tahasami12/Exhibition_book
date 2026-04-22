import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/cubit/books_cubit.dart';
import '../../home/presentation/cubit/books_state.dart';

import '../../../core/utils/responsive.dart';
import '../Widget/books_grid_view.dart';
import '../Widget/categories_bar.dart';
import '../Widget/category_icon.dart';

/// Category tab content.
/// Returns only the body — MainShell provides the Scaffold + BottomNav.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BooksCubit, BooksState>(
        builder: (context, state) {
          List<String> categories = ["All"];
          if (state is BooksLoaded) {
            final uniqueCategories = state.books
                .map((b) => b.category)
                .where((c) => c.trim().isNotEmpty)
                .toSet()
                .toList();
            categories.addAll(uniqueCategories);
          }

          return Column(
            children: [
              const CategoryIcon(),

              SizedBox(
                height: Responsive.responsiveSpacing(context, 12),
              ),

              CategoriesBar(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (cat) {
                  setState(() {
                    selectedCategory = cat;
                  });
                },
              ),

              SizedBox(
                height: Responsive.responsiveSpacing(context, 10),
              ),

              Expanded(
                child: BooksGridView(selectedCategory: selectedCategory),
              ),
            ],
          );
        },
      ),
    );
  }
}
