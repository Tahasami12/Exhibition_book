import 'package:exhibition_book/features/home/presentation/%20widgets/product_item.dart';
import 'package:exhibition_book/features/home/presentation/%20widgets/products_section.dart';
import 'package:exhibition_book/features/home/presentation/views/authors_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';

class AuthorsList extends StatelessWidget {
  const AuthorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveSpacing(context, 120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveSpacing(context, 16),
        ),
        itemCount: 4,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AuthorsView(),
                ),
              );
            },
            child: Container(
              width: Responsive.responsiveSpacing(context, 80),
              margin: EdgeInsets.only(
                right: Responsive.responsiveSpacing(context, 14),
              ),
              child: Column(
                children: [


                  CircleAvatar(
                    radius: Responsive.responsiveSpacing(context, 32),
                    backgroundImage: const AssetImage(
                      'assets/images/author.png',
                    ),
                  ),

                  SizedBox(
                    height: Responsive.responsiveSpacing(context, 6),
                  ),


                  Text(
                    "John Freeman",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                      Responsive.responsiveFontSize(context, 11),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF121212),
                    ),
                  ),

                  SizedBox(
                    height: Responsive.responsiveSpacing(context, 2),
                  ),


                  Text(
                    "Writer",
                    style: TextStyle(
                      fontSize:
                      Responsive.responsiveFontSize(context, 10),
                      color: const Color(0xFFA6A6A6), // من Figma
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