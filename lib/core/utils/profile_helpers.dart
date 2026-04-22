import 'package:exhibition_book/features/profile/models/offer_model.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// either to contact using email or phone number.
Widget makeHelpMethod({
  required AssetImage icon,
  required String label,
  required String description,
}) {
  return Expanded(
    child: InkWell(
      onTap: () {
        if (label.toLowerCase().contains("email")) {
          // put email's logic here.
        } else if (label.toLowerCase().contains("phone")) {
          // put phone's logic here.
        }
      },
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
              CircleAvatar(backgroundColor: AppColors.background, backgroundImage: icon, radius: 25,),
              SizedBox(height: 15),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.grey900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(description, style: TextStyle(color: AppColors.grey500, fontSize: 14, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    ),
  );
}

// customize screens' app bar.
AppBar makeAppBar({
  required String title,
  required Color titleColor,
  required bool enableLeading,
  required Color barBackgroundColor,
  BuildContext? context,
}) {
  return AppBar(
    backgroundColor: barBackgroundColor,
    leading:
        enableLeading && context != null
            ? GestureDetector(
              child: Icon(Icons.arrow_back, color: titleColor),
              onTap: () {
                Navigator.pop(context);
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

// builds the offer using passed color & discount value.
Widget makeOffers({required Color color, required OfferModel offer}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: color,
    ),
    width: 155,
    height: 161,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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

// the records to navigate to the offers, history, favorites, ...
Widget makeNavigationRecord({
  required BuildContext context,
  required String label,
  required String avatarName,
}) {
  final cs = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color ?? cs.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SvgPicture.asset(
            "assets/images/$avatarName",
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: "Roboto",
            color: cs.onSurface
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, color: cs.onSurface.withOpacity(0.5)),
      ],
    ),
  );
}

Widget makeBottomSheetButton({
  required Color buttonColor,
  required Color labelColor,
  required String label,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: labelColor,
        ),
      ),
    ),
  );
}
