import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/responsive.dart';
import '../../home/presentation/cubit/books_cubit.dart';
import '../../home/presentation/cubit/books_state.dart';
import 'book_card.dart';

class BooksGridView extends StatelessWidget {
  final bool isScrollable;

  const BooksGridView({super.key, this.isScrollable = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading || state is BooksInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BooksError) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is BooksLoaded) {
          final books = state.books;
          if (books.isEmpty) {
            return const Center(child: Text("No books found."));
          }

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
              crossAxisSpacing: Responsive.responsiveSpacing(context, 10),
              mainAxisSpacing: Responsive.responsiveSpacing(context, 10),
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(book: books[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
