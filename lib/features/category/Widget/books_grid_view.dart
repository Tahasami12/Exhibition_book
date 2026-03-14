import 'package:flutter/material.dart';

import 'book_card.dart';

class BooksGridView extends StatelessWidget {
  const BooksGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 38),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.73,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const BookCard();
      },
    );
  }
}
