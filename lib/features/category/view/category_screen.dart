
import 'package:flutter/material.dart';

import '../Widget/books_grid_view.dart';
import '../Widget/categories_bar.dart';
import '../Widget/category_icon.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          CategoryIcon(),


          CategoriesBar(),

          Expanded(
              child: BooksGridView())
        ],
      ),
    );

  }
}