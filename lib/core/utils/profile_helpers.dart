import 'package:exhibition_book/features/profile/models/offer_model.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/features/profile/models/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// either to contact using email or phone number.
Widget makeHelpMethod({
  required Icon icon,
  required String label,
  required String description,
}) {
  return Expanded(
    child: Container(
      height: 151,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.grey300,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundColor: AppColors.background, child: icon),
            SizedBox(height: 15),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(description, style: TextStyle(color: AppColors.grey500)),
          ],
        ),
      ),
    ),
  );
}

// customize the app bar of the screens.
AppBar makeAppBar({
  required String title,
  required Color titleColor,
  required bool enableLeading,
  required Color barBackgroundColor,
}) {
  return AppBar(
    backgroundColor: barBackgroundColor,
    leading:
        enableLeading
            ? InkWell(
              child: Icon(Icons.arrow_back, color: titleColor),
              onTap: () {
                Get.back();
              },
            )
            : null,
    title: Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    ),
    centerTitle: true,
  );
}

// builds the offer with its color & discount value.
Widget makeOffers({required Color color, required OfferModel offer}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: color,
    ),
    width: 155,
    height: 161,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(
            "${offer.offerValue.toString()}%\nOFF",
            style: TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 92,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                "Copy",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
