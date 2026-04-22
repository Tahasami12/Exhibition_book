import 'package:exhibition_book/core/utils/app_strings.dart';
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
    final t = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.vendors),
        centerTitle: true,
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 16),
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
        children: [

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              t.ourVendors,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFA6A6A6),
              ),
            ),
          ),

          const SizedBox(height: 2),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              t.vendors,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF54408C),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const VendorsTabs(),

          const SizedBox(height: 12),

          const Expanded(child: VendorsGrid()),
        ],
      ),
    );
  }
}
