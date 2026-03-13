import 'package:exhibition_book/Features/profile/models/offer_model.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> tmp = [
  {"offerValue": 20, "offerCode": "SAVE20"},
  {"offerValue": 10, "offerCode": "OFF10"},
  {"offerValue": 20, "offerCode": "SAVE20"},
  {"offerValue": 50, "offerCode": "BIG50"},
  {"offerValue": 100, "offerCode": "SUPER100"},
  {"offerValue": 50, "offerCode": "BIG50"},
];

class Offers extends StatelessWidget {
  Offers({super.key});

  // load the offers from API.
  List<OfferModel> offers = tmp.map((e) => OfferModel.fromJson(e)).toList();

  // store the colors in an array to be dynamic in assigning to the offers.
  static final List<Color> offersColors = [
    AppColors.orange,
    AppColors.primary,
    AppColors.blue,
    AppColors.yellow,
    AppColors.textPrimary,
    AppColors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: makeAppBar(
          title: "Order History",
          titleColor: AppColors.textPrimary,
          enableLeading: true,
          barBackgroundColor: AppColors.background,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              Text(
                "You Have ${offers.length} Copons to use",
                style: TextStyle(
                  color: const Color.fromARGB(255, 49, 45, 45),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30),

              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  crossAxisCount: 2,
                ),
                itemCount: offers.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeOffers(
                    offer: offers[index],
                    color: offersColors[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
