import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive.dart';
import '../cubit/books_cubit.dart';
import '../cubit/books_state.dart';
import '../views/book_details_view.dart';

/// Horizontal scrolling list of books displayed on the Home screen.
class BooksList extends StatelessWidget {
  const BooksList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveSpacing(context, 235),
      child: BlocBuilder<BooksCubit, BooksState>(
        builder: (context, state) {
          if (state is BooksLoading || state is BooksInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BooksError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is BooksLoaded) {
            final books = state.books;
            
            if (books.isEmpty) {
              return const Center(child: Text("No books found in Firestore."));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveSpacing(context, 16),
              ),
              itemCount: books.length,
              itemBuilder: (_, i) {
                final book = books[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailsPage(book: book),
                      ),
                    );
                  },
                  child: Container(
                    width: Responsive.responsiveSpacing(context, 115),
                    margin: EdgeInsets.only(
                      right: Responsive.responsiveSpacing(context, 12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Book Cover ──
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Responsive.responsiveSpacing(context, 12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Responsive.responsiveSpacing(context, 12),
                            ),
                            child: Image.network(
                              book.imageUrl,
                              width: double.infinity,
                              height: Responsive.responsiveSpacing(context, 155),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: double.infinity,
                                height: Responsive.responsiveSpacing(context, 155),
                                color: Colors.grey[200],
                                child: const Icon(Icons.book, size: 40, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Responsive.responsiveSpacing(context, 8)),

                        // ── Title ──
                        Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive.responsiveFontSize(context, 14),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF121212),
                          ),
                        ),

                        SizedBox(height: Responsive.responsiveSpacing(context, 2)),

                        // ── Price ──
                        Text(
                          "EGP ${book.price}",
                          style: TextStyle(
                            fontSize: Responsive.responsiveFontSize(context, 14),
                            color: const Color(0xFF54408C),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
