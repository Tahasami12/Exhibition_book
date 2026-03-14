import 'package:flutter/material.dart';

import '../../../core/utils/styles.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Recent Searches',style: Styles.heading2.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700
          ),),
        ],
      ),
    );
  }
}