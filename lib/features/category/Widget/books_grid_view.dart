import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import 'book_card.dart';

class BooksGridView extends StatelessWidget {
  final bool isScrollable;

  const BooksGridView({super.key, this.isScrollable = true});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),

      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 20),
        vertical: Responsive.responsiveSpacing(context, 38),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.responsiveGridCount(context),
        childAspectRatio: 0.73,
        crossAxisSpacing:
        Responsive.responsiveSpacing(context, 10),
        mainAxisSpacing:
        Responsive.responsiveSpacing(context, 10),
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const BookCard();
      },
    );
  }
}