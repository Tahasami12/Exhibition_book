import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../views/book_details_view.dart';

/// Book data model for the home screen list.
/// Keeps title, price, and image consistent across list → details flow.
class _BookData {
  final String title;
  final String price;
  final String image;

  const _BookData({
    required this.title,
    required this.price,
    required this.image,
  });
}

/// Sample book catalog — replace with API/repository data in production.
const List<_BookData> _sampleBooks = [
  _BookData(title: "The Trials of Apollo", price: "\$15.99", image: "assets/images/book.png"),
  _BookData(title: "The Alchemist", price: "\$12.49", image: "assets/images/Frame.png"),
  _BookData(title: "Atomic Habits", price: "\$18.99", image: "assets/images/Frame.png"),
  _BookData(title: "Deep Work", price: "\$14.99", image: "assets/images/Frame.png"),
  _BookData(title: "Educated", price: "\$16.49", image: "assets/images/Frame.png"),
];

/// Horizontal scrolling list of books displayed on the Home screen.
class BooksList extends StatelessWidget {
  const BooksList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveSpacing(context, 235),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveSpacing(context, 16),
        ),
        itemCount: _sampleBooks.length,
        itemBuilder: (_, i) {
          final book = _sampleBooks[i];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookDetailsPage(),
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
                      child: Image.asset(
                        book.image,
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
                    book.price,
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
      ),
    );
  }
}