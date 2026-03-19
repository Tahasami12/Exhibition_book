


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/styles.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 68,left: 24,right: 24,bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){GoRouter.of(context).push(AppRouter.kSearchHome);}, icon: Icon(FontAwesomeIcons.magnifyingGlass,size: 24,color: Colors.black,)),
          Text("Category",style: Styles.heading2.copyWith(fontWeight: FontWeight.w700,color: AppColors.grey900),
          ),IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_sharp,size: 20,)),

        ],

      ),

    );

  }

}
