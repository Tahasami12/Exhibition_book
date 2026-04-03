import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/app_colors.dart';

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
              Icon(
                Icons.notifications_none,
                size: Responsive.responsiveIconSize(context, 24),
                color: Colors.black,
              ),


            ],
          ),
        ],
      ),
    );
  }
}