import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/responsive.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Responsive.responsiveSpacing(context, 34),
        left: Responsive.responsiveSpacing(context, 24),
        right: Responsive.responsiveSpacing(context, 24),
        bottom: Responsive.responsiveSpacing(context, 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSearchHome);
            },
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: Responsive.responsiveIconSize(context, 24),
              color: Colors.black,
            ),
          ),
          Text(
            "Category",
            style: Styles.heading2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.grey900,
              // لو Styles.heading2 فيه fontSize ثابت تقدر تعمل كده:
              fontSize: Responsive.responsiveFontSize(context, 20),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_sharp,
              size: Responsive.responsiveIconSize(context, 20),
            ),
          ),
        ],
      ),
    );
  }
}