import 'package:exhibition_book/features/home/presentation/views/vendors_view.dart';
import 'package:flutter/material.dart';

import '../ widgets/authors_list.dart';
import '../ widgets/banner_section.dart';
import '../ widgets/books_list.dart';
import '../ widgets/home_app_bar.dart';
import '../ widgets/section_header.dart';
import '../ widgets/vendors_list.dart';
import 'authors_view.dart';
import 'books_view.dart';
import '../../../../core/utils/app_strings.dart';

/// The scrollable content body for the Home tab.
/// Returns only content — MainShell provides the Scaffold + BottomNav.
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    
    return SafeArea(
      child: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BannerSection(),

                  SectionHeader(
                    title: t.topOfWeek,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BooksView(),
                        ),
                      );
                    },
                  ),
                  const BooksList(),

                  SectionHeader(
                    title: t.bestVendors,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VendorsView(),
                        ),
                      );
                    },
                  ),
                  const VendorsList(),
                  const SizedBox(height: 32),

                  SectionHeader(
                    title: t.authors,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthorsView(),
                        ),
                      );
                    },
                  ),
                  const AuthorsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
