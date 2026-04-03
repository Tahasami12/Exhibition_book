import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import '../../../core/utils/styles.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});

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
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/Frame.png'),
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
            "The Da vinci Code",
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
            "\$19.99",
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