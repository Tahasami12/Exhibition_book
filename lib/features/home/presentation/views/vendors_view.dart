import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../ widgets/vendors_grid.dart';
import '../ widgets/vendors_tabs.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/responsive.dart';


class VendorsView extends StatelessWidget {
  const VendorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Vendors"),
        centerTitle: true,
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child:  IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kSearchHome);
              },
              icon: SvgPicture.asset(
                'assets/images/Search.svg',

                width: Responsive.responsiveIconSize(context, 24),
                height: Responsive.responsiveIconSize(context, 24),
              ),
            ),
          )
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Our Vendors",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFA6A6A6),
              ),
            ),
          ),

          SizedBox(height: 2),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Vendors",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF54408C),
              ),
            ),
          ),

          SizedBox(height: 10),

          VendorsTabs(),

          SizedBox(height: 12),

          Expanded(child: VendorsGrid()),
        ],
      ),
    );
  }
}