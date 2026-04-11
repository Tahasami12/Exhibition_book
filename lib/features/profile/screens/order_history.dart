import 'package:exhibition_book/features/profile/models/order_model.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

///TODO: Delete it after getting the data from an API.
List<Map<String, dynamic>> books = [
  {
    "bookTitle": "The Great Gatsby",
    "booksCount": 12,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "To Kill a Mockingbird",
    "booksCount": 8,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "1984",
    "booksCount": 15,
    "orderStatus": "Cancelled",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "Pride and Prejudice",
    "booksCount": 5,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Hobbit",
    "booksCount": 10,
    "orderStatus": "Cancelled",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Great Gatsby",
    "booksCount": 12,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "To Kill a Mockingbird",
    "booksCount": 8,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "1984",
    "booksCount": 15,
    "orderStatus": "Cancelled",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "Pride and Prejudice",
    "booksCount": 5,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Hobbit",
    "booksCount": 10,
    "orderStatus": "Cancelled",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Great Gatsby",
    "booksCount": 12,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "To Kill a Mockingbird",
    "booksCount": 8,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "1984",
    "booksCount": 15,
    "orderStatus": "Cancelled",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "Pride and Prejudice",
    "booksCount": 5,
    "orderStatus": "Delivered",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
  {
    "bookTitle": "The Hobbit",
    "booksCount": 10,
    "orderStatus": "Cancelled",
    "bookCoverURL": "assets/images/test-img.jpg",
  },
];

class OrderHistory extends StatelessWidget {
  // get access to the local date & time.
  final DateTime today = DateTime.now();
  late final String monthName = DateFormat('MMMM').format(today);

  // convert data from API form to list of OrderModel objects.
  final orders = books.map((e) => OrderModel.fromJson(e)).toList();

  OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: makeAppBar(
          title: "Order History",
          titleColor: AppColors.textPrimary,
          enableLeading: true,
          barBackgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$monthName ${today.year}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.grey900,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grey300, width: 3.0),
                  ),

                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder:
                        (c, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  orders[i].bookCoverURL ?? "",
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${orders[i].bookTitle}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.grey900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${orders[i].orderStatus?.capitalize}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                              orders[i].orderStatus!
                                                      .toLowerCase()
                                                      .contains("delivered")
                                                  ? AppColors.green
                                                  : AppColors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.grey300,
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          width: 4,
                                          height: 4,
                                        ),
                                      ),
                                      Text(
                                        "${orders[i].booksCount} items",
                                        style: TextStyle(
                                          color: AppColors.grey700,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    separatorBuilder:
                        (BuildContext context, int index) =>
                            Divider(color: AppColors.grey300),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}