import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import '../../../core/utils/styles.dart';
import '../../home/data/models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Responsive.responsiveSpacing(context, 12),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(book.imageUrl),
              ),
            ),
          ),
        ),

        SizedBox(
          height: Responsive.responsiveSpacing(context, 8),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSpacing(context, 3),
          ),
          child: Text(
            book.title,
            style: Styles.body.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xff121212),
              fontSize: Responsive.responsiveFontSize(context, 14),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(
          height: Responsive.responsiveSpacing(context, 6),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSpacing(context, 3),
          ),
          child: Text(
            "\$${book.price}",
            style: Styles.small.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xff54408C),
              fontSize: Responsive.responsiveFontSize(context, 12),
            ),
          ),
        ),
      ],
    );
  }
}