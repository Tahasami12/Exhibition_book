import 'package:flutter/material.dart';

import '../../../core/utils/styles.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(aspectRatio: 1/1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:  DecorationImage(fit: BoxFit.cover,
                    image: AssetImage('assets/images/Frame.png')
                )
            ),
          ),
        ),
        const SizedBox(height: 8),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "The Da vinci Code",
            style: Styles.body.copyWith(
                fontWeight: FontWeight.w500,
                color: Color(0xff121212)
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(height: 6),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "\$19.99",
            style: Styles.small.copyWith(
                fontWeight: FontWeight.w700,
                color: Color(0xff54408C)
            ),
          ),
        )
      ],
    );
  }
}
