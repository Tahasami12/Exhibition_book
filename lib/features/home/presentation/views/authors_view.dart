import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../ widgets/authorslistvertical.dart';
import '../ widgets/authorstabs.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/responsive.dart';

class AuthorsView extends StatelessWidget {
  const AuthorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 80,
                child: Stack(
                  children: [

                    Positioned(
                      top: 26,
                      left: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),


                    Positioned(
                      top: 32,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          t.authors,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      top: Responsive.responsiveSpacing(context, 34),
                      right: Responsive.responsiveSpacing(context, 12),
                      child: GestureDetector(
                        onTap: () {
                          context.push(AppRouter.kSearchHome);
                        },
                        child: SvgPicture.asset(
                          'assets/images/Search.svg',
                          width: Responsive.responsiveIconSize(context, 24),
                          height: Responsive.responsiveIconSize(context, 24),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                t.checkAuthors,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFA6A6A6),
                ),
              ),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                t.authors,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.35,
                  letterSpacing: -0.3,
                  color: Color(0xFF54408C),
                ),
              ),
            ),

            const SizedBox(height: 20),


            const AuthorsTabs(),

            const SizedBox(height: 18),


            const Expanded(
              child: AuthorsListVertical(),
            ),
          ],
        ),
      ),
    );
  }
}
