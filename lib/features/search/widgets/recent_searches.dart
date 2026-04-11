import 'package:flutter/material.dart';

import '../../../core/utils/responsive.dart';
import '../../../core/utils/styles.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 12),
        vertical: Responsive.responsiveSpacing(context,1 ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Recent Searches',
            style: Styles.heading2.copyWith(
              fontSize: Responsive.responsiveFontSize(context, 16),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}