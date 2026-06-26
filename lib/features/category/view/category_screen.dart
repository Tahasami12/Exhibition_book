import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/cubit/books_cubit.dart';
import '../../home/presentation/cubit/books_state.dart';

import '../../../core/utils/responsive.dart';
import '../Widget/books_grid_view.dart';
import '../Widget/categories_bar.dart';
import '../Widget/category_icon.dart';

/// Category tab content.
/// Uses a stable internal key "All" for logic, independent of locale.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  /// Internal key — always "All" for the "show all" state.
  /// Category names from books are stored as-is per locale.
  String _selectedKey = "All";

  @override
  Widget build(BuildContext context) {
    final isAr = AppStrings.isArabic(context);

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context) ?? double.infinity,
          ),
          child: BlocBuilder<BooksCubit, BooksState>(
            builder: (context, state) {
              // Build category list using EN keys always (locale-independent keys)
              // We store English category as the key, display localized label
              final Map<String, String> categoryKeys = {};
              // "All" key → localized display
              final String allLabel = isAr ? 'الكل' : 'All';
              categoryKeys["All"] = allLabel;

              if (state is BooksLoaded) {
                for (var b in state.books) {
                  final keyEn = b.categoryEn.trim();
                  if (keyEn.isNotEmpty && !categoryKeys.containsKey(keyEn.toLowerCase())) {
                    // Use English key, show localized label
                    final display = b.category(isAr).trim();
                    if (display.isNotEmpty) {
                      categoryKeys[keyEn.toLowerCase()] = display;
                    }
                  }
                }
              }

              // Build display list for bar (localized labels)
              final List<String> displayLabels = categoryKeys.values.toList();
              // Find the current display label for _selectedKey
              final String currentDisplay = categoryKeys[_selectedKey.toLowerCase()] ?? allLabel;

              return Column(
                children: [
                  const CategoryIcon(),
                  SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                  CategoriesBar(
                    categories: displayLabels,
                    selectedCategory: currentDisplay,
                    onCategorySelected: (displayName) {
                      // Find the EN key for this display label
                      final key = categoryKeys.entries
                          .firstWhere(
                            (e) => e.value == displayName,
                            orElse: () => const MapEntry("All", "All"),
                          )
                          .key;
                      setState(() {
                        _selectedKey = key;
                      });
                    },
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(context, 10)),
                  Expanded(
                    child: BooksGridView(selectedCategoryKey: _selectedKey),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
