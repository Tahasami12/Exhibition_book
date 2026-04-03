import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../views/book_details_view.dart';


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
        itemCount: 5,
        itemBuilder: (_, i) {
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


                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Responsive.responsiveSpacing(context, 16),
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
                        'assets/images/Frame.png',
                        width: double.infinity,
                        height: Responsive.responsiveSpacing(context, 155),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Responsive.responsiveSpacing(context, 8),
                  ),


                  Text(
                    "The Kite Runner",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:
                      Responsive.responsiveFontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF121212),
                    ),
                  ),

                  SizedBox(
                    height: Responsive.responsiveSpacing(context, 2),
                  ),


                  Text(
                    "\$19.99",
                    style: TextStyle(
                      fontSize:
                      Responsive.responsiveFontSize(context, 14),
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