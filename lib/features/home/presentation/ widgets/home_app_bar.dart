import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../notification_feature/presentation/views/notification.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 16),
        vertical: Responsive.responsiveSpacing(context, 26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Icon(
            Icons.search,
            size: Responsive.responsiveIconSize(context, 24),
            color: Colors.black,
          ),


          Text(
            "Home",
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 20),
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),


          Stack(
            clipBehavior: Clip.none,
            children: [
          IconButton(
          icon: Icon(
          Icons.notifications,
            size: Responsive.responsiveSpacing(context, 24),
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
    ]
          ),
        ],
      ),
    );
  }
}