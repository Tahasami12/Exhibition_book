import 'package:exhibition_book/features/search/widgets/recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/responsive.dart';
import 'custom_search_text.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.responsiveSpacing(context, 16),
        Responsive.responsiveSpacing(context, 26),
        Responsive.responsiveSpacing(context, 16),
        Responsive.responsiveSpacing(context, 15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.grey900,
                  size: Responsive.responsiveIconSize(context, 24),
                ),
              ),

              SizedBox(
                width: Responsive.responsiveSpacing(context, 97),
              ),

              Text(
                'Search',
                style: Styles.heading2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey900,
                  fontSize: Responsive.responsiveFontSize(context, 20),
                ),
              ),
            ],
          ),

          SizedBox(
            height: Responsive.responsiveSpacing(context, 20),
          ),

          const CustomSearchText(),

          SizedBox(
            height: Responsive.responsiveSpacing(context, 20),
          ),

          const RecentSearches(),
        ],
      ),
    );
  }
}