import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/styles.dart';

class CustomSearchText extends StatelessWidget {
  const CustomSearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 23),
        child:Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xffFAFAFA)),
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              hintText: "Search",
              hintStyle: Styles.body.copyWith(color: AppColors.grey500),//TextStyle(color: AppColors.grey500,s),


              prefixIcon: const Opacity(
                opacity: .5,
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 18,
                  color: AppColors.grey500,
                ),
              ),

              enabledBorder: buildBorder(),
              focusedBorder: buildBorder(),
              border: buildBorder(),

              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),)
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    );
  }
}