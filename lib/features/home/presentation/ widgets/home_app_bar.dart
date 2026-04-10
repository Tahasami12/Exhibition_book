import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
        horizontal: Responsive.responsiveSpacing(context, 16),
        vertical: Responsive.responsiveSpacing(context, 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ── Search Icon ──
          Icon(
            Icons.search,
            size: Responsive.responsiveIconSize(context, 24),
            color: Colors.black,
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
            icon: Icon(
              Icons.notifications_outlined,
              size: Responsive.responsiveIconSize(context, 24),
              color: Colors.black,
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