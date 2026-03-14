
import 'package:exhibition_book/Features/search/widgets/recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/styles.dart';
import 'custom_search_text.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:24,vertical: 68 ),
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){GoRouter.of(context).push(AppRouter.kCategory);}, icon: Icon(Icons.arrow_back_outlined,color: AppColors.grey900,)
              ),
              SizedBox(
                width: 97,
              ),
              Text('Search',
                style: Styles.heading2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey900,
                ),

              ),

            ],

          ),
          CustomSearchText(),

          RecentSearches()
        ],
      ),

    );

  }
}