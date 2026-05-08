import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/responsive.dart';
import '../../../notification_feature/presentation/cubit/notification_cubit.dart';
import '../../../notification_feature/presentation/cubit/notification_state.dart';
import '../../../notification_feature/presentation/views/notification.dart';

/// Top app bar widget for the Home screen.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {


        final int notificationCount =
            state.deliveries.length + state.news.length;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSpacing(context, 24),
            vertical: Responsive.responsiveSpacing(context, 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// Search Button
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

              /// Title
              Text(
                t.navHome,
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 20),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              /// Notification Button
              Stack(
                clipBehavior: Clip.none,
                children: [
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

                  /// Notification Counter
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Center(
                        child: Text(
                          '$notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}