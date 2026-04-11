import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/styles.dart';
import '../../../core/utils/responsive.dart';

class CustomSearchText extends StatelessWidget {
  const CustomSearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 12),
        vertical: Responsive.responsiveSpacing(context, 15),
      ),
      child: Container(
        height: Responsive.responsiveSpacing(context, 48),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(
            Responsive.responsiveSpacing(context, 8),
          ),
          border: Border.all(color: const Color(0xffFAFAFA)),
        ),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
            hintText: "Search",
            hintStyle: Styles.body.copyWith(
              color: AppColors.grey500,
              fontSize: Responsive.responsiveFontSize(context, 14),
            ),

            prefixIcon: Opacity(
              opacity: .5,
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: Responsive.responsiveIconSize(context, 18),
                color: AppColors.grey500,
              ),
            ),

            enabledBorder: buildBorder(context),
            focusedBorder: buildBorder(context),
            border: buildBorder(context),

            contentPadding: EdgeInsets.symmetric(
              vertical: Responsive.responsiveSpacing(context, 8),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        Responsive.responsiveSpacing(context, 12),
      ),
    );
  }
}