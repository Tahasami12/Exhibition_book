import 'package:exhibition_book/features/home/presentation/views/vendors_view.dart';
import 'package:flutter/material.dart';

import '../ widgets/authors_list.dart';
import '../ widgets/banner_section.dart';
import '../ widgets/books_list.dart';
import '../ widgets/custom_bottom_nav.dart';
import '../ widgets/home_app_bar.dart';
import '../ widgets/section_header.dart';
import '../ widgets/vendors_list.dart';
import 'authors_view.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

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

                    SectionHeader(title: 'Top of Week'),
                    const BooksList(),

                    SectionHeader(
                      title: 'Best Vendors',
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
                    SizedBox(height: 32),

                    SectionHeader(
                      title: 'Authors',
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

      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }
}