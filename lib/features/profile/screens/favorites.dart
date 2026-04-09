import 'package:exhibition_book/features/profile/models/favorite_model.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///TODO: Delete it after getting the data from API.
List<Map<String, dynamic>> favoriteBooks = [
  {
    "bookTitle": "The Great Gatsby",
    "booksCount": 12,
    "bookPrice": 10.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "To Kill a Mockingbird",
    "bookPrice": 10.01,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "1984",
    "bookPrice": 11.99,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "Pride and Prejudice",
    "bookPrice": 35.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Hobbit",
    "bookPrice": 20.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Great Gatsby",
    "booksCount": 12,
    "bookPrice": 10.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "To Kill a Mockingbird",
    "bookPrice": 10.01,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "1984",
    "bookPrice": 11.99,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "Pride and Prejudice",
    "bookPrice": 35.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Hobbit",
    "bookPrice": 20.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Great Gatsby",
    "booksCount": 12,
    "bookPrice": 10.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "To Kill a Mockingbird",
    "bookPrice": 10.01,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "1984",
    "bookPrice": 11.99,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "Pride and Prejudice",
    "bookPrice": 35.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Hobbit",
    "bookPrice": 20.00,
    "bookCoverURL": "assets/images/test-img.jpg",
  },
];

class Favorites extends StatelessWidget {
  final favorites =
      favoriteBooks.map((e) => FavoriteModel.fromJson(e)).toList();
  Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: makeAppBar(
          title: "Your Favorites",
          titleColor: AppColors.textPrimary,
          enableLeading: true,
          barBackgroundColor: AppColors.background,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  separatorBuilder: (c, i) => Divider(),
                  itemCount: favorites.length,
                  itemBuilder:
                      (c, i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  favorites[i].bookCoverURL ?? "",
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${favorites[i].bookTitle}",
                                    style: TextStyle(
                                      color: AppColors.grey900,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "\$${favorites[i].bookPrice!.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/favorite.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
