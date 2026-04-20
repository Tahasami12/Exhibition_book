import 'package:exhibition_book/features/home/presentation/%20widgets/product_item.dart';
import 'package:flutter/material.dart';

class AuthorItem extends StatelessWidget {
  const AuthorItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AuthorDetailsPage(),
            ),
          );
        },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          const CircleAvatar(
            radius: 34,
            backgroundImage: AssetImage('assets/images/author.png'),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [


                Text(
                  "John Freeman",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                    letterSpacing: -0.3,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 6),


                Text(
                  "American writer he was the editor of the ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFFA6A6A6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}