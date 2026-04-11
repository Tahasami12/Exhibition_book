import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../notification_feature/presentation/views/notification.dart';

/// Top app bar widget for the Home screen.
/// Contains a search icon, centered title, and notification bell.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 24),
        vertical: Responsive.responsiveSpacing(context, 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSearchHome);
            },
            icon: SvgPicture.asset(
              'assets/images/Search.svg',
              width: Responsive.responsiveIconSize(context, 24),
              height: Responsive.responsiveIconSize(context, 24),
            ),
          ),
          // ── Title ──
          Text(
            "Home",
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 20),
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          // ── Notification Button ──
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/Notification.svg',
              width: Responsive.responsiveIconSize(context, 24),
              height: Responsive.responsiveIconSize(context, 24),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}