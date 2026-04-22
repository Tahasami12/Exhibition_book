import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/responsive.dart';
import '../../notification_feature/presentation/views/notification.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(
          Responsive.responsiveSpacing(context, 16),
          Responsive.responsiveSpacing(context, 26),
          Responsive.responsiveSpacing(context, 16),
          Responsive.responsiveSpacing(context, 16),
        ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.push(AppRouter.kSearchHome);
            },
            icon: SvgPicture.asset(
              'assets/images/Search.svg',
              width: Responsive.responsiveIconSize(context, 24),
              height: Responsive.responsiveIconSize(context, 24),
            ),
          ),
          Text(
            t.navCategory,
            style: Styles.heading2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.grey900,

              fontSize: Responsive.responsiveFontSize(context, 20),
            ),
          ),
          IconButton(
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationScreen(),
              ),
            );},
            icon: SvgPicture.asset(
              'assets/images/Notification.svg',
              width: Responsive.responsiveIconSize(context, 24),
              height: Responsive.responsiveIconSize(context, 24),
            ),
          ),
        ],
      ),
    );
  }
}
