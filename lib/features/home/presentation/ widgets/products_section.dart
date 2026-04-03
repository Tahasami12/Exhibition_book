import 'package:exhibition_book/features/home/presentation/%20widgets/product_item.dart';
import 'package:flutter/material.dart';

import '../../../category/Widget/books_grid_view.dart';


class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Products",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 1),

            const BooksGridView(),
          ],
        )
      ],
    );
  }
}